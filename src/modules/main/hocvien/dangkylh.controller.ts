import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { FunctionService } from 'src/services/function.service';
import { Hocvien } from 'src/models/hocvien/hocvien.entity';
import { hocvienService } from 'src/services/hocvien.service';


@Controller("dangkylh")
export class DangkylhController {
    constructor( private functionService: FunctionService ,  private hocvienService: hocvienService) {}
    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("hocvien/dangkylh/index.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string;
        if(!picture) picture = "/images/faces/face11.jpg";

        const email: string = req.user["email"] as string;
        let user: Hocvien = await this.hocvienService.getByEmail(email);
        var list  =  await this.functionService.xemdanhsach_dangky_hientai_HV(user.MaHV);
        // console.log(list[0]);

        const viewBag = {
            picture: picture,
            list:list[0]
        }
        return viewBag;
    }
    @Post("/getAlllh")
    @UseGuards(AuthGuard('jwt'))
    async getAlllh(@Body() data: any) {
        var list  =  await this.functionService.xemdanhsachLH_dangmo(data.MaKH);
        var list2  =  await this.functionService.xemdanhsachTKB_LH_dangmo(data.MaKH);

        // console.log(data.MaKH);
        return {
            list:list,
            list2:list2
        }
    }

    @Post("/dangky")
    @UseGuards(AuthGuard('jwt'))
    async dangkylophoc(@Req() req: Request,@Body() data: any) {
        const email: string = req.user["email"] as string;
        let user: Hocvien = await this.hocvienService.getByEmail(email);
        var list  =  await this.functionService.dangkylophoc(user.MaHV, data.MaLH);
        // console.log(list[0]);
        return list[0];
    }

    @Post("/huydangky")
    @UseGuards(AuthGuard('jwt'))
    async huydangkylophoc(@Body() data: any) {
        var list  =  await this.functionService.huydangkylophoc(data.MaHV, data.MaLH);
        console.log(data.MaHV, data.MaLH);
        return list[0];
    }

    @Post("/chuyenlophoc")
    @UseGuards(AuthGuard('jwt'))
    async chuyenlophoc(@Req() req: Request,@Body() data: any) {
        const email: string = req.user["email"] as string;
        let user: Hocvien = await this.hocvienService.getByEmail(email);
        var list  =  await this.functionService.chuyenlophoc(user.MaHV, data.MaLH , data.Malophientai);
        // console.log(list[0]);
        return list[0];
    }

    
}