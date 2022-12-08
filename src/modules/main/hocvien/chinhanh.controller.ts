import { KhoahocService } from './../../../services/khoahoc.service';
import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Hocvien } from 'src/models/hocvien/hocvien.entity';

import { FunctionService } from 'src/services/function.service';


@Controller("chinhanh")
export class ChinhanhController {
    constructor( private khoahocService: KhoahocService,private functionService: FunctionService) {}
    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("hocvien/listchinhanh/index.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        var picture: string = req.user["picture"] as string;
        if(!picture) picture = "/images/faces/face11.jpg";
        
        const data = await this.functionService.getAllchinhanh();
        // console.log(data);
        const viewBag = {
            picture: picture,
            data: data
        }
        return viewBag;
    }
}