import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Application } from './application.entity';
import { Category } from '../category/category.entity';

@Injectable()
export class ApplicationsService {
  constructor(
    @InjectRepository(Application)
    private applicationsRepository: Repository<Application>,
    @InjectRepository(Category)
    private categoriesRepository: Repository<Category>,
  ) {}

  async findAll(): Promise<Application[]> {
    return this.applicationsRepository.find({
      where: { status: 1 }, // HANYA AMBIL YANG STATUS = 1 (active)
      relations: ['category'],
      order: { title: 'ASC' }
    });
  }

  async findAllGroupedByCategory(): Promise<{ [key: string]: Application[] }> {
    const applications = await this.findAll();
    const grouped: { [key: string]: Application[] } = {};

    applications.forEach(app => {
      const categoryName = app.category.name;
      if (!grouped[categoryName]) {
        grouped[categoryName] = [];
      }
      grouped[categoryName].push(app);
    });

    return grouped;
  }

  // TAMBAHKAN METHOD UNTUK MENDAPATKAN SEMUA DATA (TERMASUK YANG DIHAPUS)
  async findAllIncludingDeleted(): Promise<Application[]> {
    return this.applicationsRepository.find({
      relations: ['category'],
      order: { title: 'ASC' }
    });
  }

  async create(appData: Partial<Application>): Promise<Application> {
    if (!appData.categoryId) {
      throw new NotFoundException('Category ID is required');
    }

    const category = await this.categoriesRepository.findOne({ 
      where: { id: appData.categoryId } 
    });

    if (!category) {
      throw new NotFoundException(`Category with ID ${appData.categoryId} not found`);
    }

    const application = this.applicationsRepository.create({
      title: appData.title,
      fullName: appData.fullName,
      url: appData.url,
      icon: appData.icon,
      category: category,
      status: 1 // DEFAULT STATUS ACTIVE
    });

    return this.applicationsRepository.save(application);
  }

  async update(id: number, updateData: Partial<Application>): Promise<Application> {
    const application = await this.applicationsRepository.findOne({ 
      where: { id },
      relations: ['category']
    });

    if (!application) {
      throw new NotFoundException(`Application with ID ${id} not found`);
    }

    // Jika ada categoryId baru, update category
    if (updateData.categoryId) {
      const category = await this.categoriesRepository.findOne({ 
        where: { id: updateData.categoryId } 
      });
      
      if (!category) {
        throw new NotFoundException('Category not found');
      }
      
      application.category = category;
    }

    // Update field lainnya
    if (updateData.title) application.title = updateData.title;
    if (updateData.fullName) application.fullName = updateData.fullName;
    if (updateData.url) application.url = updateData.url;
    if (updateData.icon) application.icon = updateData.icon;

    return this.applicationsRepository.save(application);
  }

  // UBAH METHOD REMOVE UNTUK SOFT DELETE
  async remove(id: number): Promise<void> {
    const application = await this.applicationsRepository.findOne({ 
      where: { id } 
    });

    if (!application) {
      throw new NotFoundException(`Application with ID ${id} not found`);
    }

    // UPDATE STATUS MENJADI 0 (DELETED) BUKAN HAPUS DATA
    application.status = 0;
    await this.applicationsRepository.save(application);
  }

  // TAMBAHKAN METHOD UNTUK RESTORE DATA
  async restore(id: number): Promise<Application> {
    const application = await this.applicationsRepository.findOne({ 
      where: { id } 
    });

    if (!application) {
      throw new NotFoundException(`Application with ID ${id} not found`);
    }

    application.status = 1;
    return this.applicationsRepository.save(application);
  }
}