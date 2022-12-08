import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Hocvien } from 'src/models/hocvien/hocvien.entity';
import { hocvienService } from 'src/services/hocvien.service';
import { FunctionService } from 'src/services/function.service';
import { Console } from 'console';
import { KhoahocService } from 'src/services/khoahoc.service';
import { Khoahoc } from 'src/models/khoahoc/khoahoc.entity';

@Controller("capnhatgt")
export class CapnhatgtController {
    constructor( private khoahocService: KhoahocService,private functionService: FunctionService) {}
    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("quanlygiaoduc/updategt/index.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string; 
        if(!picture) picture = "/images/faces/face11.jpg";
        let giaotrinh = await this.functionService.DanhsachToanboGiaotrinh();
        let khoahoc = await this.functionService.getAllkhoahoc();
        const viewBag = {
            picture: picture,
            giaotrinh:giaotrinh[0],
            khoahoc:khoahoc[0]
        }
        return viewBag;
    }
    @Post("/getAllgt")
    @UseGuards(AuthGuard('jwt'))
    async getAllgt(@Body() data: any) {
        var list  =  await this.functionService.getAllgt(data.MaKH);
        // console.log(list);
        return list;
    }

    @Post("/delete")
    @UseGuards(AuthGuard('jwt'))
    async delete(@Body() data: any) {
        var list  =  await this.functionService.delete(data.MaKH,data.MaGT);
        // console.log(list[0][0].Result);
    
        return list[0][0].Result; 
    }
    @Post("/add")
    @UseGuards(AuthGuard('jwt'))
    async add(@Body() data: any,@Res() res: Response) {
        var list  =  await this.functionService.themmoi_gt_kh(data.MaKH,data.MaGT);
        // console.log(data);  
        res.redirect("/capnhatgt");  
        // return list[0][0].Result; 
    }
}