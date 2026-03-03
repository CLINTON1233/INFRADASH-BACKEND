import {
  Controller,
  Post,
  Body,
  Put,
  Param,
  Get,
  Delete,
  Res,
  Req,
  UnauthorizedException,
} from '@nestjs/common';
import { UsersService } from './users.service';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import type { Response, Request } from 'express';

@Controller('users')
export class UsersController {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  // GET Users
  @Get()
  async getAllUsers() {
    try {
      const users = await this.usersService.findAll();
      return {
        status: 'success',
        users: users,
      };
    } catch (error) {
      return {
        status: 'error',
        message: 'Failed to fetch users',
      };
    }
  }

  // POST /users/register - TAMBAHKAN INI
  @Post('register')
  async register(@Body() body) {
    try {
      // Cek apakah email sudah terdaftar
      const existingUser = await this.usersService.findByEmail(body.email);
      if (existingUser) {
        return {
          status: 'error',
          message: 'Email already registered',
        };
      }

      // Buat user baru
      const newUser = await this.usersService.create({
        nama: body.nama,
        email: body.email,
        password: body.password,
        badge: body.badge,
        telp: body.telp,
        departemen: body.departemen,
        role: body.role || 'admin',
      });

      // Hapus password dari response
      const { password, ...result } = newUser;

      return {
        status: 'success',
        message: 'User created successfully',
        user: result,
      };
    } catch (error) {
      console.error('Error creating user:', error);
      return {
        status: 'error',
        message: 'Failed to create user',
      };
    }
  }

  // PUT /users/:id - TAMBAHKAN INI
  @Put(':id')
  async updateUser(@Param('id') id: string, @Body() body) {
    try {
      const userId = parseInt(id);

      // Cek apakah user ada
      const existingUser = await this.usersService.findById(userId);
      if (!existingUser) {
        return {
          status: 'error',
          message: 'User not found',
        };
      }

      // Update user
      const updateData: any = {
        nama: body.nama,
        badge: body.badge,
        telp: body.telp,
        departemen: body.departemen,
        role: body.role,
      };

      // Jika ada password baru, tambahkan ke updateData
      if (body.password) {
        updateData.password = body.password;
      }

      const updatedUser = await this.usersService.update(userId, updateData);

      // Hapus password dari response
      const { password, ...result } = updatedUser;

      return {
        status: 'success',
        message: 'User updated successfully',
        user: result,
      };
    } catch (error) {
      console.error('Error updating user:', error);
      return {
        status: 'error',
        message: 'Failed to update user',
      };
    }
  }

  // DELETE /users/:id - TAMBAHKAN INI
  @Delete(':id')
  async deleteUser(@Param('id') id: string) {
    try {
      const userId = parseInt(id);

      // Cek apakah user ada
      const existingUser = await this.usersService.findById(userId);
      if (!existingUser) {
        return {
          status: 'error',
          message: 'User not found',
        };
      }

      // Delete user
      await this.usersService.delete(userId);

      return {
        status: 'success',
        message: 'User deleted successfully',
      };
    } catch (error) {
      console.error('Error deleting user:', error);
      return {
        status: 'error',
        message: 'Failed to delete user',
      };
    }
  }

  @Post('login')
  async login(@Body() body, @Res({ passthrough: true }) response: Response) {
    const { email, password } = body;
    const user = await this.usersService.findByEmail(email);
    if (!user) return { status: 'error', message: 'Email tidak ditemukan' };

    const match = await bcrypt.compare(password, user.password);
    if (!match) return { status: 'error', message: 'Password salah' };

    const payload = {
      id: user.id,
      role: user.role,
      email: user.email,
      nama: user.nama,
    };

    const token = await this.jwtService.signAsync(payload, {
      expiresIn: '24h', // Token expired dalam 24 jam
    });

    // Set HTTP-only cookie (lebih aman)
    response.cookie('portal_token', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production', // HTTPS only in production
      sameSite: 'lax',
      maxAge: 24 * 60 * 60 * 1000, // 24 jam dalam milidetik
      path: '/',
    });

    // Set regular cookie untuk client-side access jika diperlukan
    response.cookie('token', token, {
      httpOnly: false, // Client-side bisa akses
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 24 * 60 * 60 * 1000, // 24 jam dalam milidetik
      path: '/',
    });

    return {
      status: 'success',
      message: 'Login berhasil',
      token,
      expiresIn: 86400, // 24 jam dalam detik
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

  @Post('logout')
  async logout(@Res({ passthrough: true }) response: Response) {
    // Hapus cookies
    response.clearCookie('portal_token');
    response.clearCookie('token');

    return { status: 'success', message: 'Logout berhasil' };
  }

  @Get('check-session')
  async checkSession(@Req() request: Request) {
    try {
      // Cek token dari cookie
      const token = request.cookies['portal_token'] || request.cookies['token'];

      if (!token) {
        // Return 401 Unauthorized instead of 200 with authenticated: false
        throw new UnauthorizedException('No token provided');
      }

      // Verifikasi token
      const decoded = this.jwtService.verify(token);

      // Ambil data user terbaru
      const user = await this.usersService.findById(decoded.id);

      if (!user) {
        throw new UnauthorizedException('User not found');
      }

      return {
        status: 'success',
        authenticated: true,
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
    } catch (error) {
      // Throw proper HTTP exception so frontend gets 401/403 status
      if (error.name === 'TokenExpiredError') {
        throw new UnauthorizedException('Token expired');
      }
      if (error.name === 'JsonWebTokenError') {
        throw new UnauthorizedException('Invalid token');
      }
      throw new UnauthorizedException('Session invalid');
    }
  }

  @Post('verify-for-monitoring')
  async verifyTokenForMonitoring(
    @Body() body: { token: string },
    @Req() request: Request,
  ) {
    try {
      // Cek token dari body atau cookie
      let token = body.token;

      if (!token) {
        token = request.cookies['portal_token'] || request.cookies['token'];
      }

      if (!token) {
        throw new UnauthorizedException('No token provided');
      }

      // Verify token
      const decoded = this.jwtService.verify(token);

      // Get user data
      const user = await this.usersService.findById(decoded.id);

      if (!user) {
        throw new UnauthorizedException('User not found');
      }

      // Return data yang diperlukan
      return {
        status: 'success',
        authenticated: true,
        user: {
          id: user.id,
          nama: user.nama,
          email: user.email,
          badge: user.badge,
          telp: user.telp,
          departemen: user.departemen,
          role: user.role,
          permissions: this.getUserPermissions(user.role),
        },
      };
    } catch (error) {
      console.error('Token verification error:', error);
      return {
        status: 'error',
        authenticated: false,
        message: 'Invalid or expired token',
      };
    }
  }

  private getUserPermissions(role: string) {
    const permissions = {
      view_dashboard: true,
      view_cameras: true,
      view_reports: false,
      manage_devices: false,
    };

    if (role === 'superadmin' || role === 'admin') {
      permissions.view_reports = true;
      permissions.manage_devices = true;
    }

    return permissions;
  }
}
