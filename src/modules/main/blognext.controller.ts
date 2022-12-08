import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
@Controller("blognext")
export class BlognextController {

    @Get()  
    @Render("home/blognext")
    async index(@Req() req: Request, @Res() res: Response) {
    }
}