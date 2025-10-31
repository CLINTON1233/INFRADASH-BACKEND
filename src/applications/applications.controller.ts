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
  Patch,
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

  // ENDPOINT BARU UNTUK MENDAPATKAN SEMUA DATA (TERMASUK YANG DIHAPUS)
  @Get('all')
  getAllIncludingDeleted(): Promise<Application[]> {
    return this.appsService.findAllIncludingDeleted();
  }

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
          const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
          const ext = extname(file.originalname);
          callback(null, `icon-${uniqueSuffix}${ext}`);
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
      categoryId: parseInt(body.categoryId),
    };
    return this.appsService.create(appData);
  }

  @Put(':id')
  @UseInterceptors(
    FileInterceptor('iconFile', {
      storage: diskStorage({
        destination: './uploads',
        filename: (req, file, callback) => {
          const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
          const ext = extname(file.originalname);
          callback(null, `icon-${uniqueSuffix}${ext}`);
        },
      }),
    }),
  )
  async update(
    @Param('id', ParseIntPipe) id: number,
    @UploadedFile() file: Express.Multer.File,
    @Body() body: any,
  ): Promise<Application> {
    const updateData: Partial<Application> = {
      title: body.title,
      fullName: body.fullName,
      url: body.url,
    };

    if (body.categoryId) {
      updateData.categoryId = parseInt(body.categoryId);
    }

    if (file) {
      updateData.icon = file.filename;
    } else if (body.icon) {
      updateData.icon = body.icon;
    }

    return this.appsService.update(id, updateData);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.appsService.remove(id);
  }

  // ENDPOINT BARU UNTUK RESTORE DATA
  @Patch(':id/restore')
  restore(@Param('id', ParseIntPipe) id: number): Promise<Application> {
    return this.appsService.restore(id);
  }
}