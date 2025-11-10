import { Controller, Post, Body, Put, Param, Get, Delete } from '@nestjs/common';
import { UsersService } from './users.service';
import * as bcrypt from 'bcrypt';

@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}

  // GET all users
  @Get()
  async getAllUsers() {
    const users = await this.usersService.findAll();
    return { status: 'success', users };
  }

  // POST register new user
  @Post('register')
  async register(@Body() body) {
    if (!body.email) return { status: 'error', message: 'Email is required' };
    if (!body.password) return { status: 'error', message: 'Password is required' };
    
    const existing = await this.usersService.findByEmail(body.email);
    if (existing) return { status: 'error', message: 'Email already exists' };
    
    const user = await this.usersService.create(body);
    return { status: 'success', user };
  }

  // PUT update user
  @Put(':id')
  async update(@Param('id') id: number, @Body() body) {
    const updatedUser = await this.usersService.update(id, body);
    return { status: 'success', user: updatedUser };
  }

  // DELETE user
  @Delete(':id')
  async delete(@Param('id') id: number) {
    await this.usersService.delete(id);
    return { status: 'success', message: 'User deleted successfully' };
  }

  @Post('login')
  async login(@Body() body) {
    const { email, password } = body;
    const user = await this.usersService.findByEmail(email);
    if (!user) return { status: 'error', message: 'Email tidak ditemukan' };
    const match = await bcrypt.compare(password, user.password);
    if (!match) return { status: 'error', message: 'Password salah' };

    return {
      status: 'success',
      message: 'Login berhasil',
      user: {
        id: user.id,
        nama: user.nama,
        email: user.email,
        badge: user.badge,
        telp: user.telp,
        departemen: user.departemen,
        role: user.role,
      },
    };
  }
}