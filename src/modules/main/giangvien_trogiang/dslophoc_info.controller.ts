import { FunctionService } from './../../../services/function.service';
import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Userservice } from 'src/services/user.service';
import { user_nv } from 'src/models/nhanvien/user_nv.entity';
@Controller("dslophoc")
export class DslophocController {
    constructor (private userservice: Userservice , private functionService: FunctionService) {}

    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("giaovientrogiang/classlist/index.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string;
        var email: string = req.user["email"] as string;
        const user1 = await this.functionService.getUser(email);

        // var checkdataa = await this.functionService.Check_GV_TG(user1.nhanvienMaNV );
        var data = await this.functionService.DanhsachLH_phutrach_Thongtinchitiet_LH(user1[0].nhanvienMaNV);
        var data1 = await this.functionService.DanhsachLH_phutrach_Thongtinchitiet_GV(user1[0].nhanvienMaNV);
        var data2 = await this.functionService.DanhsachLH_phutrach_Thongtinchitiet_TG(user1[0].nhanvienMaNV);
        // console.log(data1);
        if(!picture) picture = "/images/faces/face11.jpg";
        const viewBag = {
            data:data[0],
            data1:data1[0],
            data2:data2[0],
            picture: picture
        }
        return viewBag;
    }
}