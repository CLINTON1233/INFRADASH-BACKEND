import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Icon } from './icon.entity';

@Injectable()
export class IconsService {
  constructor(
    @InjectRepository(Icon)
    private iconsRepository: Repository<Icon>,
  ) {}

  async findAll(): Promise<Icon[]> {
    return this.iconsRepository.find({
      order: { name: 'ASC' }
    });
  }

  async findByCategory(category: string): Promise<Icon[]> {
    return this.iconsRepository.find({
      where: { category },
      order: { name: 'ASC' }
    });
  }
}