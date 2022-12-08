import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { FunctionService } from 'src/services/function.service';
@Controller("product")
export class ProductController {
    constructor (
        private functionService: FunctionService) {}
    @Get()  
    @Render("home/product")
    async index(@Req() req: Request, @Res() res: Response) {
        var list  =  await this.functionService.getAllkhoahoc();
   
        var data;
        for( var i = 0; i < list[0].length; i++ ) {
                if( list[0][i].up==true){
                    data = list[0][i];
                }
        }
        if (!data) data=list[0][0];
        await this.functionService.offup(data.MaKH);
        // console.log(data);
        const viewBag = {
            data: data,
      
        }
        return viewBag;

    }
}