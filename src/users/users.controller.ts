import { Controller, Post, Body } from '@nestjs/common';
import { UsersService } from './users.service';
import * as bcrypt from 'bcrypt';

@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}

  @Post('register')
  async register(@Body() body) {
    if (!body.email) return { status: 'error', message: 'Email is required' };

    const existing = await this.usersService.findByEmail(body.email);
    if (existing) return { status: 'error', message: 'Email already exists' };

    const user = await this.usersService.create(body);
    return { status: 'success', user };
  }

  @Post('login')
  async login(@Body() body) {
    const { email, password } = body;
    const user = await this.usersService.findByEmail(email);
    if (!user) {
      return { status: 'error', message: 'Email tidak ditemukan' };
    }

    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      return { status: 'error', message: 'Password salah' };
    }

    return {
      status: 'success',
      message: 'Login berhasil',
      user: {
        id: user.id,
        nama: user.nama,
        email: user.email,
        role: user.role,
      },
    };
  }
}
