
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy } from 'passport-local';
import * as bcrypt from 'bcrypt'; 
import { hocvienService } from 'src/services/hocvien.service';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
    constructor( private hocvienService: hocvienService) {
        super({
            usernameField: 'email'
        });
    }
//Authentication : Xác Thực   
//Authorication: Xác Nhận
    async validate(email: string, password: string) {
        const user = await this.hocvienService.getByEmail(email);
        console.log(user);
        if (!user) throw new UnauthorizedException("Không tồn tại tài khoản này");
        if (!(await bcrypt.compare(password, user.password))) throw new UnauthorizedException("Sai tài khoản hoặc mật khẩu");
        return { //Return 1 cái json
            email: user.Email
        };
    }
}
