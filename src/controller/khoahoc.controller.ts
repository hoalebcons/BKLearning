// import { Response, Request } from 'express';
// import { Controller, Get, Render, Post, Body, Res, UseGuards } from "@nestjs/common";
// import {KhoahocService } from "../services/khoahoc.service"
// import { Khoahoc } from 'src/models/khoahoc/khoahoc.entity';
// @Controller("khoahoc")
// export class KhoahocController {
//     constructor(private khoahocService: KhoahocService) { }
//     @Get()
//     @Render("khoahoc/index")
//     async index() {
//     }

//     @Post("/checkId")
//     async checkId(@Body('id') id: string) {
//         let khoahoc = await this.khoahocService.getById(id);
//         if (!khoahoc) return {
//             status: "NOT_FOUND"
//         }
//         return {
//             khoahoc: "FOUND"
//         }
//     }
//     @Post("/add")
//     async add(@Res() res: Response, @Body() khoahoc: any) {
//         var khoahocToAdd: Khoahoc = new Khoahoc();
//         khoahocToAdd.MaKH = khoahoc.MaKH;
//         khoahocToAdd.Ten = khoahoc.Ten;
//         khoahocToAdd.Hocphi = khoahoc.Hocphi;
//         khoahocToAdd.Thoiluong = khoahoc.Thoiluong;
//         khoahocToAdd.Trangthai = khoahoc.Trangthai;
//         khoahocToAdd.Gioihansiso = khoahoc.Gioihansiso;
//         khoahocToAdd.Yeucautrinhdo = khoahoc.Yeucautrinhdo;
//         console.log(khoahoc.Gioihansiso);
//         console.log( khoahoc.Yeucautrinhdo);
//         await this.khoahocService.add(khoahocToAdd);
//         res.redirect("/khoahoc");
//     }
// }