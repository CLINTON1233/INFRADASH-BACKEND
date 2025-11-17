import { Controller, Get } from '@nestjs/common';
import { IconsService } from './icons.service';
import { Icon } from './icon.entity';

@Controller('icons')
export class IconsController {
  constructor(private readonly iconsService: IconsService) {}

  @Get()
  getAll(): Promise<Icon[]> {
    return this.iconsService.findAll();
  }
}