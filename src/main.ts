import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { join } from 'path';
import { NestExpressApplication } from '@nestjs/platform-express';
import cookieParser from 'cookie-parser';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  // Tambahkan cookie parser
  app.use(cookieParser());

  // Konfigurasi CORS untuk cookie
  app.enableCors({
    origin: [
      'http://localhost:3000',
      'http://localhost:3003',
      'http://localhost:3002',
      'http://localhost:3005',
    ],
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
    allowedHeaders: ['Content-Type', 'Authorization', 'Accept'],
  });

  // 🔥 expose folder uploads
  app.useStaticAssets(join(__dirname, '..', 'uploads'), {
    prefix: '/uploads/',
  });

  await app.listen(4000);
  console.log(`Server running on http://localhost:4000`);
}
bootstrap();
