import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Hocvien } from 'src/models/hocvien/hocvien.entity';
import { hocvienService } from 'src/services/hocvien.service';
import { FunctionService } from 'src/services/function.service';
import { Console } from 'console';
import { KhoahocService } from 'src/services/khoahoc.service';
import { Khoahoc } from 'src/models/khoahoc/khoahoc.entity';

@Controller("giangviendskh")
export class GiangviendskhController {
    constructor( private khoahocService: KhoahocService,private functionService: FunctionService) {}
    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("giaovientrogiang/courselist/index.pug")
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
}