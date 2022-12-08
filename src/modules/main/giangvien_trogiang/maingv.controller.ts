import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import * as bcrypt from 'bcrypt';
import { user_nv } from 'src/models/nhanvien/user_nv.entity';
import { Userservice } from 'src/services/user.service';
@Controller("giangvien")
export class GiangvienmainController {
    constructor (private userservice: Userservice) {}

    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("giaovientrogiang/layout.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string;
        if(!picture) picture = "/images/faces/face11.jpg";
        const viewBag = {
            picture: picture
        }
        return viewBag;
    }
}