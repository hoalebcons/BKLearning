import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
@Controller("home")
export class MainController {

    @Get()  
    @Render("home/index")
    async index(@Req() req: Request, @Res() res: Response) {
    }
}