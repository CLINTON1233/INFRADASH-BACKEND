import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { user } from './users/user.entity';
import { UsersModule } from './users/users.module';
import { Application } from './applications/application.entity';
import { ApplicationsModule } from './applications/applications.module';
import { Category } from './category/category.entity';
import { Icon } from './icon/icon.entity';
import { IconsModule } from './icon/icons.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'postgres',
      password: 'Sukses12345',
      database: 'infradash',
      entities: [user, Application, Category, Icon],
      synchronize: true,
    }),
    UsersModule,
    ApplicationsModule,
    IconsModule,
  ],
  controllers: [AppController,],
  providers: [AppService],
})
export class AppModule {}
