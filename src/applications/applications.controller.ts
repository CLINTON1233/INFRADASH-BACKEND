import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Param,
  ParseIntPipe,
} from '@nestjs/common';
import { ApplicationsService } from './applications.service';
import { Application } from './application.entity';
import { Put } from '@nestjs/common';

@Controller('applications')
export class ApplicationsController {
  constructor(private readonly appsService: ApplicationsService) {}

  @Get()
  getAll(): Promise<Application[]> {
    return this.appsService.findAll();
  }

  @Post()
  create(@Body() body: Partial<Application>): Promise<Application> {
    return this.appsService.create(body);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() body: Partial<Application>,
  ): Promise<Application> {
    return this.appsService.update(id, body);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    // <--- parse id ke number
    return this.appsService.remove(id);
  }
}
