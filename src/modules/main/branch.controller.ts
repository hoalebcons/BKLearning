import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
@Controller("branch")
export class BranchController {

    @Get()  
    @Render("home/branch")
    async index(@Req() req: Request, @Res() res: Response) {
    }
}