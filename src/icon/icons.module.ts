import { Module, OnModuleInit } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Icon } from './icon.entity';
import { IconsController } from './icons.controller';
import { IconsService } from './icons.service';

@Module({
  imports: [TypeOrmModule.forFeature([Icon])],
  controllers: [IconsController],
  providers: [IconsService],
})
export class IconsModule implements OnModuleInit {
  constructor(private readonly iconsService: IconsService) {}

  async onModuleInit() {
    try {
      await this.iconsService.seedDefaultIcons();
    } catch (error) {
      console.error('Error seeding icons:', error);
    }
  }
}
