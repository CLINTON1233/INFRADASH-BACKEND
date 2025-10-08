import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { user } from './user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([user])],
  providers: [UsersService],
  controllers: [UsersController],
})
export class UsersModule {}
