import { user_nv } from './../models/nhanvien/user_nv.entity';

import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from 'typeorm';

@Injectable()
export class Userservice {
    constructor(
        @InjectRepository(user_nv) private userRepository: Repository<user_nv>
    ) { }

    async getAll(): Promise<user_nv[]> {
        return await this.userRepository.find();
    }

    async getOne(id: string): Promise<user_nv> {
        return await this.userRepository.findOne(Number(id)); //Phải convert id sang number vì id của faculty là NUMBER chứ không phải là string
    }

    async getByemail(email: string): Promise<user_nv> {
        return await this.userRepository.findOne(email);
    }

    async add(khoahoc: user_nv): Promise<void> {
        //console.log(Khoahoc);
        await this.userRepository.insert(khoahoc);
    }

    // async edit(Khoahoc: user_nv): Promise<void> {
    //     await this.userRepository.update(Khoahoc.MaKH, Khoahoc);
    // }
    

}
