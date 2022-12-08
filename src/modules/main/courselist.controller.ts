import { Response, Request } from 'express';
import { Controller, Get, Render, Post, Body, Res, UseGuards, Req } from "@nestjs/common";
import { AuthGuard } from '@nestjs/passport'; 
import { Hocvien } from 'src/models/hocvien/hocvien.entity';
import { hocvienService } from 'src/services/hocvien.service';
import { FunctionService } from 'src/services/function.service';

@Controller("courselist")
export class CourselistController {
    constructor( private hocvienService: hocvienService,private functionService: FunctionService) {}
    @Get()  
    @UseGuards(AuthGuard('jwt'))
    @Render("layout.pug")
    async index(@Req() req: Request, @Res() res: Response) {
        // var picture: string = req.user["picture"] as string;
        // var email: string = req.user["email"] as string;
        // if(!picture) picture = "/images/faces/face11.jpg";
        // const data = await this.functionService.getAllkhoahoc('KN001');
        // console.log(data);
        // const viewBag = {
        //     picture: picture,
        //     data: data
        // }
        // return viewBag;
    }
    @Post("/update")
    @UseGuards(AuthGuard('jwt'))
    async edit(@Req() req: Request,@Res() res: Response, @Body() student: any) {
        const email: string = req.user["email"] as string;
        const getbyemail = await this.hocvienService.getByEmail(email);
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
        studentToEdit.Email = email;
        if (!getbyemail){
            console.log(getbyemail);
            var newid = Math.floor(1000000 + Math.random() * 9000000);
            var getbyID = await this.hocvienService.getById(newid.toString());
            while(getbyID){
                newid = Math.floor(1000000 + Math.random() * 9000000);
                getbyID = await this.hocvienService.getById(newid.toString());
            }
            studentToEdit.MaHV = newid.toString();
            await this.hocvienService.add(studentToEdit);
        }
        else{
            studentToEdit.MaHV = getbyemail.MaHV;
            await this.hocvienService.savedata(studentToEdit);
        }
        // await this.studentService.edit(studentToEdit);
        res.redirect("/updatehocvien");  
    }
}