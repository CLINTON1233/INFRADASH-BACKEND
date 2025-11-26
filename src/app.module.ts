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
import { JwtModule } from '@nestjs/jwt';

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
    JwtModule.register({
   global: true,
   secret: "SECRET_KEY_KAMU",
   signOptions: { expiresIn: "1d" },
 }),
    UsersModule,
    ApplicationsModule,
    IconsModule,
  ],
  controllers: [AppController,],
  providers: [AppService],
})
export class AppModule {}
