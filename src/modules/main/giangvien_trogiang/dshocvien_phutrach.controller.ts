import { FunctionService } from './../../../services/function.service';
import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Userservice } from 'src/services/user.service';
import { user_nv } from 'src/models/nhanvien/user_nv.entity';
import * as bcrypt from 'bcrypt';
@Controller("dshopvien")
export class DshocvienController {
    constructor (private userservice: Userservice , private functionService: FunctionService) {}

    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("giaovientrogiang/studentlist/index.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string;

        // var user1 = new user_nv();
        // user1.username = "admin";
        // const salt = await bcrypt.genSalt(15);
        // user1.password = await bcrypt.hash("admin",salt);
        // await this.userservice.add(user1);

        if(!picture) picture = "/images/faces/face11.jpg";
        const viewBag = {
            picture: picture
        }
        return viewBag;
    }

    @Post("/getdshocvien")
    @UseGuards(AuthGuard('jwt'))
    async getAllgt(@Body() data: any,@Req() req: Request) {
        var email: string = req.user["email"] as string;
        const user1 = await this.functionService.getUser(email);
        var list  =  await this.functionService.DanhsachHV_thuocLH_phutrach(data.MaLH,user1[0].nhanvienMaNV);

        // console.log(list[0]);
        return list;
    }
}