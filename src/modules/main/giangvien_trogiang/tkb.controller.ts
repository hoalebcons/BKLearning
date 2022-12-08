import { FunctionService } from './../../../services/function.service';
import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Userservice } from 'src/services/user.service';
import { user_nv } from 'src/models/nhanvien/user_nv.entity';
@Controller("thoikhoabieu")
export class ThoikhoabieuController {
    constructor (private userservice: Userservice , private functionService: FunctionService) {}

    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("giaovientrogiang/tkbnhanvien/index.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string;

        if(!picture) picture = "/images/faces/face11.jpg";
        const viewBag = {
            picture: picture,
        }
        return viewBag;
    }
    @Post("/getdata")
    @UseGuards(AuthGuard('jwt'))
    async getAllgt(@Body() data: any,@Req() req: Request) {
        var email: string = req.user["email"] as string;
        const user1 = await this.functionService.getUser(email);
        var data  =  await this.functionService.DanhsachLH_phutrach_Thongtinchitiet_TKB(user1[0].nhanvienMaNV);
        console.log((typeof data[0]))
        // console.log(list[0]);
        return data[0];
    }


}