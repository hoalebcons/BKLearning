import { GoogleStrategy } from './google.strategy';
import { ConfigModule } from '@nestjs/config';
import { JwtStrategy } from './jwt.strategy';
// import { LocalStrategy } from './local.strategy';
// import { UserService } from './../../services/user.service';
// import { User } from './../../models/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
// import { AuthController } from './auth.controller';
import { Module } from '@nestjs/common';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import { AuthController } from './auth.controller';
import { hocvienService } from 'src/services/hocvien.service';
import { Hocvien } from 'src/models/hocvien/hocvien.entity';
import { LocalStrategy } from './local.strategy';


@Module({
  imports: [
    PassportModule,
    ConfigModule.forRoot(),
    TypeOrmModule.forFeature([Hocvien]),
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      signOptions: {
        expiresIn: 60 * 30,
      },
    }),
    TypeOrmModule.forFeature([Hocvien]),
  ],
  providers: [JwtStrategy, GoogleStrategy,hocvienService,LocalStrategy],
  controllers: [AuthController],
})
export class AuthModule {}
