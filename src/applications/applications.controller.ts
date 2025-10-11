import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Param,
  ParseIntPipe,
  Put,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApplicationsService } from './applications.service';
import { Application } from './application.entity';
import { diskStorage } from 'multer';
import { extname } from 'path';

@Controller('applications')
export class ApplicationsController {
  constructor(private readonly appsService: ApplicationsService) {}

  @Get()
  getAll(): Promise<Application[]> {
    return this.appsService.findAll();
  }

  // Endpoint baru untuk mendapatkan aplikasi yang sudah dikelompokkan
  @Get('grouped')
  getGroupedByCategory(): Promise<{ [key: string]: Application[] }> {
    return this.appsService.findAllGroupedByCategory();
  }

  @Post()
  @UseInterceptors(
    FileInterceptor('iconFile', {
      storage: diskStorage({
        destination: './uploads',
        filename: (req, file, callback) => {
          const uniqueSuffix =
            Date.now() + '-' + Math.round(Math.random() * 1e9);
          const ext = extname(file.originalname);
          callback(null, `${file.fieldname}-${uniqueSuffix}${ext}`);
        },
      }),
    }),
  )
  async create(
    @UploadedFile() file: Express.Multer.File,
    @Body() body: any,
  ): Promise<Application> {
    const appData: Partial<Application> = {
      title: body.title,
      fullName: body.fullName,
      url: body.url,
      icon: file ? file.filename : body.icon,
      category: body.category || 'Uncategorized', // Tambahkan kategori
    };
    return this.appsService.create(appData);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() body: Partial<Application>,
  ): Promise<Application> {
    return this.appsService.update(id, {
      title: body.title,
      fullName: body.fullName,
      url: body.url,
      icon: body.icon,
      category: body.category || 'Uncategorized', // Tambahkan ini
    });
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.appsService.remove(id);
  }
}
