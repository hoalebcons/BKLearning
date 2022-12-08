import { DslophocController } from './giangvien_trogiang/dslophoc_info.controller';
import { GiangvienmainController } from './giangvien_trogiang/maingv.controller';
import { BlognextController } from './blognext.controller';
import { Khoahoc } from './../../models/khoahoc/khoahoc.entity';

import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Hocvien } from "src/models/hocvien/hocvien.entity";
import { hocvienService } from "src/services/hocvien.service";

import { JwtStrategy } from "../auth/jwt.strategy";
import { MainController } from "./main.controller";
import { RegisterController } from "./hocvien/register.controller";
import { UpdateinfoController } from "./hocvien/updateinfo.controller";
import { CourselistController } from "./courselist.controller";
import { FunctionService } from "src/services/function.service";
import { CapnhatkhController } from "./quanlygiaoduc/capnhatkh.controller";
import { QlgdmainController } from "./quanlygiaoduc/qlgdmain.controller";
import { KhoahocService } from "src/services/khoahoc.service"; 
import { CapnhatgtController } from './quanlygiaoduc/capnhatgt.controller';
import { HocviencourselistController } from './hocvien/courselist.controller';
import { DangkylhController } from './hocvien/dangkylh.controller';
import { CatalogController } from './catalog.controller';
import { ProductController } from './product.controller';
import { BranchController } from './branch.controller';
import { BlogController } from './blog.controller';
import { ContactController } from './contact.controller';
import { BlogprevController } from './blogprev.controller';
import { BlogarticleController } from './blogarticle.controller';
import { CapnhatlhController } from './quanlygiaoduc/capnhatlh.controller';
import { GiangviendskhController } from './giangvien_trogiang/gv_courselist.controller';
import { Userservice } from 'src/services/user.service';
import { user_nv } from 'src/models/nhanvien/user_nv.entity';
import { DshocvienController } from './giangvien_trogiang/dshocvien_phutrach.controller';
import { ThoikhoabieuController } from './giangvien_trogiang/tkb.controller';
import { ChinhanhController } from './hocvien/chinhanh.controller';


@Module({
    imports: [TypeOrmModule.forFeature([Hocvien,Khoahoc,user_nv])],
    providers: [hocvienService,FunctionService,KhoahocService,Userservice],
    controllers: [MainController,UpdateinfoController,RegisterController,CourselistController,
    CapnhatkhController,QlgdmainController,CapnhatgtController,HocviencourselistController,CatalogController,
    DangkylhController,ProductController,BranchController,BlogController,ContactController,BlognextController,BlogprevController,
    BlogarticleController,CapnhatlhController,GiangvienmainController,GiangviendskhController,DslophocController,DshocvienController,ThoikhoabieuController,
    ChinhanhController]
})
  
export class MainModule { }
