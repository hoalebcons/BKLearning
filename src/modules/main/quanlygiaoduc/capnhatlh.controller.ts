import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Hocvien } from 'src/models/hocvien/hocvien.entity';
import { hocvienService } from 'src/services/hocvien.service';
import { FunctionService } from 'src/services/function.service';
import { Console } from 'console';
import { KhoahocService } from 'src/services/khoahoc.service';
import { Khoahoc } from 'src/models/khoahoc/khoahoc.entity';

@Controller("capnhatlh")
export class CapnhatlhController {
    constructor( private khoahocService: KhoahocService,private functionService: FunctionService) {}
    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("quanlygiaoduc/updatelh/index.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string;
        if(!picture) picture = "/images/faces/face11.jpg";
        
        const data = await this.functionService.xemdanhsacLH();
        // console.log(data);
        const viewBag = {
            picture: picture,
            data:data
        }
        return viewBag;
    }

    @Post("/add")
    @UseGuards(AuthGuard('jwt'))
    async add(@Body() data: any,@Res() res: Response) {
        var list  =  await this.functionService.lophoc_insert(data.MaLH,data.Ngaybatdau,data.Ngayketthuc,data.MaCN,data.MaKH); 
        res.redirect("/capnhatlh");  
        // return list[0][0].Result; 
    }
    @Post("/edit")
    @UseGuards(AuthGuard('jwt'))
    async edit(@Body() data: any,@Res() res: Response) {
        // console.log(data.MaLH,data.Ngaybatdau,data.Ngayketthuc,data.MaCN,data.MaKH);
        var list  =  await this.functionService.lophoc_update(data.MaLH,data.Ngaybatdau,data.Ngayketthuc,data.MaCN,data.MaKH); 
        // console.log(list);
        res.redirect("/capnhatlh");  
        // return list[0][0].Result; 
    }
    @Post("/delete")
    @UseGuards(AuthGuard('jwt'))
    async delete(@Body() data: any,@Res() res: Response) {
        // console.log(data.MaLH,data.Ngaybatdau,data.Ngayketthuc,data.MaCN,data.MaKH);
        var list  =  await this.functionService.lophoc_delete(data.MaLH); 
        // console.log(list);
        res.redirect("/capnhatlh");  
        // return list[0][0].Result; 
    }
}