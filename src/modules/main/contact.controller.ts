import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
@Controller("contact")
export class ContactController {

    @Get()  
    @Render("home/contacts")
    async index(@Req() req: Request, @Res() res: Response) {
    }
}