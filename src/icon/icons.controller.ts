import { Controller, Get, Post, Param, ParseIntPipe } from '@nestjs/common';
import { IconsService } from './icons.service';
import { Icon } from './icon.entity';

@Controller('icons')
export class IconsController {
  constructor(private readonly iconsService: IconsService) {}

  @Get()
  getAll(): Promise<Icon[]> {
    return this.iconsService.findAll();
  }

  @Get(':id')
  getOne(@Param('id', ParseIntPipe) id: number): Promise<Icon> {
    return this.iconsService.findOne(id);
  }

  @Post('seed')
  async seedIcons(): Promise<{ message: string }> {
    await this.iconsService.seedDefaultIcons();
    return { message: 'Default icons seeded successfully' };
  }
}
