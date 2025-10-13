import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Category } from './category.entity';

@Injectable()
export class CategoriesService {
  constructor(
    @InjectRepository(Category)
    private categoriesRepository: Repository<Category>,
  ) {}

  async findAll(): Promise<Category[]> {
    return this.categoriesRepository.find({
      order: { name: 'ASC' }
    });
  }

  async findOne(id: number): Promise<Category> {
    const category = await this.categoriesRepository.findOne({ where: { id } });
    if (!category) {
      throw new NotFoundException(`Category with ID ${id} not found`);
    }
    return category;
  }

  async findByName(name: string): Promise<Category | null> {
    return this.categoriesRepository.findOne({ where: { name } });
  }

  async create(categoryData: Partial<Category>): Promise<Category> {
    const category = this.categoriesRepository.create(categoryData);
    return this.categoriesRepository.save(category);
  }

  async seedDefaultCategories(): Promise<void> {
    const defaultCategories = [
      { name: 'Network', description: 'Network infrastructure and connectivity applications' },
      { name: 'Server', description: 'Server management and monitoring applications' },
      { name: 'Cloud', description: 'Cloud services and platforms' },
      { name: 'Security', description: 'Security and access management applications' },
      { name: 'Database', description: 'Database management systems' },
      { name: 'Monitoring', description: 'System monitoring and alerting tools' },
      { name: 'Storage', description: 'Storage and backup solutions' },
      { name: 'Virtualization', description: 'Virtualization and container platforms' },
      { name: 'Collaboration', description: 'Collaboration and communication tools' },
      { name: 'Development', description: 'Development and DevOps tools' },
      { name: 'Documentation', description: 'Documentation and knowledge base systems' },
      { name: 'Automation', description: 'Automation and orchestration tools' },
      { name: 'ITSM', description: 'IT Service Management applications' },
      { name: 'Backup', description: 'Backup and recovery solutions' },
      { name: 'Compliance', description: 'Compliance and governance tools' },
      { name: 'Reporting', description: 'Reporting and analytics applications' },
      { name: 'API Management', description: 'API management and gateway services' },
      { name: 'Identity Management', description: 'Identity and access management systems' },
      { name: 'Network Security', description: 'Network security appliances and tools' },
      { name: 'Container Platform', description: 'Container orchestration platforms' },
    ];

    for (const categoryData of defaultCategories) {
      const existingCategory = await this.findByName(categoryData.name);
      if (!existingCategory) {
        await this.create(categoryData);
        console.log(`Created category: ${categoryData.name}`);
      }
    }
    
    console.log('Default categories seeding completed');
  }
}