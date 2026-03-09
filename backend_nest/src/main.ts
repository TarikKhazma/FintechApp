import { NestFactory } from '@nestjs/core';
import { ValidationPipe, BadRequestException } from '@nestjs/common';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // CORS — allow Flutter app from any origin
  app.enableCors({ origin: '*' });

  // Auto-validate all incoming DTOs
  // Converts class-validator errors → { message: "..." } so Flutter reads them correctly
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      exceptionFactory: (errors) => {
        const message = Object.values(errors[0].constraints)[0];
        return new BadRequestException({ message });
      },
    }),
  );

  await app.listen(3000, '0.0.0.0');
  console.log('Server running on http://0.0.0.0:3000');
}

bootstrap();
