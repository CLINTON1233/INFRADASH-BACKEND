import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Application } from './application.entity';

@Injectable()
export class ApplicationsService {
  constructor(
    @InjectRepository(Application)
    private readonly appRepo: Repository<Application>,
  ) {}

  findAll(): Promise<Application[]> {
    return this.appRepo.find();
  }

  create(appData: Partial<Application>): Promise<Application> {
    const newApp = this.appRepo.create(appData);
    return this.appRepo.save(newApp);
  }

  async update(
    id: number,
    appData: Partial<Application>,
  ): Promise<Application> {
    await this.appRepo.update(id, appData);
    const updated = await this.appRepo.findOne({ where: { id } });
    if (!updated) {
      throw new Error('Application not found');
    }
    return updated;
  }
  async remove(id: number): Promise<void> {
    await this.appRepo.delete(id);
  }
}
