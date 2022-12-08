import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Hocvien } from 'src/models/hocvien/hocvien.entity';
import { hocvienService } from 'src/services/hocvien.service';
import { FunctionService } from 'src/services/function.service';
import { Console } from 'console';
import { KhoahocService } from 'src/services/khoahoc.service';
import { Khoahoc } from 'src/models/khoahoc/khoahoc.entity';

@Controller("capnhatkh")
export class CapnhatkhController {
    constructor( private khoahocService: KhoahocService,private functionService: FunctionService) {}
    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("quanlygiaoduc/updatekh/index.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string;
        if(!picture) picture = "/images/faces/face11.jpg";
        
        const data = await this.khoahocService.getAll();
        // console.log(data[0][1]);
        const viewBag = {
            picture: picture,
            data: data[0]
        }
        return viewBag;
    }

    @Post("/update")
    @UseGuards(AuthGuard('jwt'))
    async edit(@Req() req: Request,@Res() res: Response, @Body() khoahoc: any) {

        var khoahocToEdit: Khoahoc = new Khoahoc();  
        khoahocToEdit.MaKH = khoahoc.MaKH;
        khoahocToEdit.Ten = khoahoc.Ten;
        khoahocToEdit.Hocphi = khoahoc.Hocphi;
        khoahocToEdit.Thoiluong = khoahoc.Thoiluong;
        khoahocToEdit.Gioihansiso = khoahoc.Gioihansiso;
        khoahocToEdit.Yeucautrinhdo = khoahoc.Yeucautrinhdo;
        khoahocToEdit.Trangthai = khoahoc.Trangthai;
        khoahocToEdit.Noidung = khoahoc.Noidung; 
        // console.log(khoahocToEdit);
        await this.khoahocService.edit(khoahocToEdit);
        res.redirect("/capnhatkh");  
    }

    @Post("/data_gt_tg")
    @UseGuards(AuthGuard('jwt'))
    async getgvtg( @Body() makh: any) {

        var listgv = await this.functionService.data_gv(makh.MaKH);
        var listtg = await this.functionService.data_tg(makh.MaKH);
        console.log(listgv);
        return {
            listgv:listgv, 
            listtg:listtg
        }

    }
}