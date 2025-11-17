import { Module, OnModuleInit } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Application } from './application.entity';
import { Category } from '../category/category.entity';
import { ApplicationsController } from './applications.controller';
import { ApplicationsService } from './applications.service';
import { CategoriesService } from '../category/categories.service';
import { CategoriesController } from '../category/categories.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Application, Category])],
  controllers: [ApplicationsController, CategoriesController],
  providers: [ApplicationsService, CategoriesService],
})
export class ApplicationsModule implements OnModuleInit {
  constructor(private readonly categoriesService: CategoriesService) {}

  async onModuleInit() {
    try {
      await this.categoriesService.seedDefaultCategories();
    } catch (error) {
      console.error('Error seeding categories:', error);
    }
  }
}