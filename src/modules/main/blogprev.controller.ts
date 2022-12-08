import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
@Controller("blogprev")
export class BlogprevController {

    @Get()  
    @Render("home/blogprev")
    async index(@Req() req: Request, @Res() res: Response) {
    }
}