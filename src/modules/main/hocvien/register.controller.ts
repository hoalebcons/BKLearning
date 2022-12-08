import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Hocvien } from 'src/models/hocvien/hocvien.entity';
import { hocvienService } from 'src/services/hocvien.service';
import * as bcrypt from 'bcrypt';


@Controller("register")
export class RegisterController {
    constructor( private hocvienService: hocvienService) {}
    @Get()  
    @Render("register/index.pug")
    async index() {

    }

    @Post("/checkId")
    async checkId(@Body('email') email: string) {
        let student = await this.hocvienService.getByEmail(email);
        if (!student) return {
            status: "NOT_FOUND"
        }
        return {
            status: "FOUND"
        }
    }
    @Post("/add")
    async edit(@Req() req: Request,@Res() res: Response, @Body() student: any) {
        var studentToEdit: Hocvien = new Hocvien();
        studentToEdit.Ho = student.fname;
        studentToEdit.Tendem = student.bname;
        studentToEdit.Ten = student.lname;
        studentToEdit.gioitinh = student.gender;
        studentToEdit.Namsinh = student.bday;
        studentToEdit.Sonha = student.sonha;
        studentToEdit.Duong = student.duong;
        studentToEdit.Quanhuyen = student.quan;
        studentToEdit.Tinhtp = student.city;
        studentToEdit.Sodienthoai = student.pnumber;
        studentToEdit.Email = student.email;
        studentToEdit.password = student.pass;
        // console.log(studentToEdit);
        const salt = await bcrypt.genSalt(15);
        studentToEdit.password = await bcrypt.hash(studentToEdit.password,salt);
  
        var newid = Math.floor(1000000 + Math.random() * 9000000);
        var getbyID = await this.hocvienService.getById(newid.toString());
        while(getbyID){
            newid = Math.floor(1000000 + Math.random() * 9000000);
            getbyID = await this.hocvienService.getById(newid.toString());
        }
        studentToEdit.MaHV = newid.toString();
        await this.hocvienService.add(studentToEdit);
        res.redirect("/login");
    }
}