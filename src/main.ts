import * as cookieParser from 'cookie-parser';
import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { join } from 'path';
import { AppModule } from './app.module';
import * as moment from 'moment';
import * as session from "express-session";
import flash = require("connect-flash");
async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.enableCors();
  app.useStaticAssets(join(__dirname, '..', 'public'));
  app.setBaseViewsDir(join(__dirname, '..', 'views'));
  app.setViewEngine('pug');
  app.use(cookieParser());
  app.use(
    session({
      secret: process.env["SESSION_SECRET"],
      resave: false,
      saveUninitialized: false,
    })
  );
  app.use(flash());
  moment.locale('vi');
  app.setLocal("moment", moment);
  await app.listen(process.env.PORT || 3000);
}
bootstrap();
