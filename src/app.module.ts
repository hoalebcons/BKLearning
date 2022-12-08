import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { APP_FILTER } from '@nestjs/core';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UnauthorizedExceptionFilter } from './filters/unauthorized-exception.filter';
import { AuthModule } from './modules/auth/auth.module';
import { MainModule } from './modules/main/main.module';

@Module({
  imports: [TypeOrmModule.forRoot(), ConfigModule.forRoot(),AuthModule,MainModule],
  controllers: [AppController],
  providers: [AppService,    
    {
    provide: APP_FILTER,
    useClass: UnauthorizedExceptionFilter
  },],
})
export class AppModule {}
