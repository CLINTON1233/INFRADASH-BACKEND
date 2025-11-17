import { Injectable, NotFoundException } from '@nestjs/common';
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
      order: { name: 'ASC' },
    });
  }

  async findByCategory(category: string): Promise<Icon[]> {
    return this.iconsRepository.find({
      where: { category },
      order: { name: 'ASC' },
    });
  }

  async findOne(id: number): Promise<Icon> {
    const icon = await this.iconsRepository.findOne({ where: { id } });
    if (!icon) {
      throw new NotFoundException(`Icon with ID ${id} not found`);
    }
    return icon;
  }

  async seedDefaultIcons(): Promise<void> {
    const defaultIcons = [
      // General Icons
      { name: 'Globe', icon_key: 'Globe', category: 'General' },
      { name: 'Monitor', icon_key: 'Monitor', category: 'General' },
      { name: 'Laptop', icon_key: 'Laptop', category: 'General' },
      { name: 'Smartphone', icon_key: 'Smartphone', category: 'General' },
      { name: 'Tablet', icon_key: 'Tablet', category: 'General' },

      // Network Icons
      { name: 'Wifi', icon_key: 'Wifi', category: 'Network' },
      { name: 'Server', icon_key: 'Server', category: 'Network' },
      { name: 'Cloud', icon_key: 'Cloud', category: 'Network' },
      { name: 'Database', icon_key: 'Database', category: 'Network' },
      { name: 'HardDrive', icon_key: 'HardDrive', category: 'Network' },

      // Security Icons
      { name: 'Shield', icon_key: 'Shield', category: 'Security' },
      { name: 'Lock', icon_key: 'Lock', category: 'Security' },
      { name: 'Key', icon_key: 'Key', category: 'Security' },
      { name: 'Fingerprint', icon_key: 'Fingerprint', category: 'Security' },

      // Development Icons
      { name: 'Code', icon_key: 'Code', category: 'Development' },
      { name: 'GitBranch', icon_key: 'GitBranch', category: 'Development' },
      { name: 'Terminal', icon_key: 'Terminal', category: 'Development' },
      { name: 'Cog', icon_key: 'Cog', category: 'Development' },
      { name: 'Settings', icon_key: 'Settings', category: 'Development' },

      // Communication Icons
      { name: 'Mail', icon_key: 'Mail', category: 'Communication' },
      {
        name: 'MessageCircle',
        icon_key: 'MessageCircle',
        category: 'Communication',
      },
      { name: 'Phone', icon_key: 'Phone', category: 'Communication' },
      { name: 'Video', icon_key: 'Video', category: 'Communication' },

      // File Icons
      { name: 'File', icon_key: 'File', category: 'Files' },
      { name: 'Folder', icon_key: 'Folder', category: 'Files' },
      { name: 'Download', icon_key: 'Download', category: 'Files' },
      { name: 'Upload', icon_key: 'Upload', category: 'Files' },

      // Media Icons
      { name: 'Image', icon_key: 'Image', category: 'Media' },
      { name: 'Film', icon_key: 'Film', category: 'Media' },
      { name: 'Music', icon_key: 'Music', category: 'Media' },
      { name: 'Play', icon_key: 'Play', category: 'Media' },

      // Business Icons
      { name: 'Briefcase', icon_key: 'Briefcase', category: 'Business' },
      { name: 'Users', icon_key: 'Users', category: 'Business' },
      { name: 'User', icon_key: 'User', category: 'Business' },
      { name: 'BarChart', icon_key: 'BarChart', category: 'Business' },

      // Navigation Icons
      { name: 'Home', icon_key: 'Home', category: 'Navigation' },
      { name: 'Compass', icon_key: 'Compass', category: 'Navigation' },
      { name: 'MapPin', icon_key: 'MapPin', category: 'Navigation' },
      { name: 'Navigation', icon_key: 'Navigation', category: 'Navigation' },
    ];

    for (const iconData of defaultIcons) {
      const existingIcon = await this.iconsRepository.findOne({
        where: { icon_key: iconData.icon_key },
      });

      if (!existingIcon) {
        const icon = this.iconsRepository.create(iconData);
        await this.iconsRepository.save(icon);
        console.log(`Created icon: ${iconData.name}`);
      }
    }

    console.log('Default icons seeding completed');
  }
}
