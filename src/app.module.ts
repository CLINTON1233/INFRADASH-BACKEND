import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { user } from './users/user.entity';
import { UsersModule } from './users/users.module';
import { Application } from './applications/application.entity';
import { ApplicationsModule } from './applications/applications.module'; 

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'postgres',
      password: 'Sukses12345',
      database: 'infradash',
      entities: [user, Application],
      synchronize: true,
    }),
    UsersModule,
    ApplicationsModule, 
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
