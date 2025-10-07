import { Controller, Post, Body } from '@nestjs/common';
import { UsersService } from './users.service';
import { User } from './user.entity';

@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}

  @Post('register')
  async register(@Body() body: Partial<User>) {
    if (!body.email) {
      return { status: 'error', message: 'Email is required' };
    }
    const existing = await this.usersService.findByEmail(body.email);
    if (existing) {
      return { status: 'error', message: 'Email already exists' };
    }
    const user = await this.usersService.create(body);
    return { status: 'success', user };
  }
}
