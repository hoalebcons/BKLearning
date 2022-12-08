import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
@Controller("blog")
export class BlogController {

    @Get()  
    @Render("home/blog")
    async index(@Req() req: Request, @Res() res: Response) {
    }
}