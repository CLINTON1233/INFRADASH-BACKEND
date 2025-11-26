// src/auth/auth.controller.ts 
import { Controller, Get, Post, Req, Res } from '@nestjs/common';
import type { Request, Response } from 'express';

@Controller('auth')
export class AuthController {
  // Endpoint cek login (yang sudah ada)
  @Get('check')
  check(@Req() req: Request, @Res() res: Response) {
    const token = req.cookies['portal_token'];
    if (token) {
      return res.json({ authenticated: true });
    }
    return res.status(401).json({ authenticated: false });
  }

  // TAMBAHAN: Endpoint logout → INI YANG BIKIN COOKIE DIHAPUS BENAR-BENAR!
  @Post('logout')
  logout(@Res({ passthrough: true }) res: Response) {
res.clearCookie('portal_token', {
  httpOnly: true,
  secure: process.env.NODE_ENV === 'production',
  sameSite: 'lax',
  path: '/',
  // Hapus domain: 'localhost'
});
    return res.json({ success: true, message: 'Logged out' });
  }
}