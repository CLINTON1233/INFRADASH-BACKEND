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
      expiresIn: '30m', // Token expired dalam 30 menit
    });

    // Set HTTP-only cookie (lebih aman)
    response.cookie('portal_token', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production', // HTTPS only in production
      sameSite: 'lax',
      maxAge: 30 * 60 * 1000, // 30 menit dalam milidetik
      path: '/',
    });

    // Set regular cookie untuk client-side access jika diperlukan
    response.cookie('token', token, {
      httpOnly: false, // Client-side bisa akses
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 30 * 60 * 1000,
      path: '/',
    });

    return {
      status: 'success',
      message: 'Login berhasil',
      token,
      expiresIn: 1800, // 30 menit dalam detik
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
      return {
        status: 'error',
        authenticated: false,
        message: 'Session expired or invalid',
      };
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
