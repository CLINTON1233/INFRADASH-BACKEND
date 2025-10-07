import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Tambahkan ini untuk izinkan frontend akses
  app.enableCors({
    origin: 'http://localhost:3000', // alamat Next.js kamu
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
  });

  await app.listen(4000); // ⬅️ ganti ke 4000
  console.log(` Server running on http://localhost:4000`);
}
bootstrap();
