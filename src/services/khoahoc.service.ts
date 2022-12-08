import { Khoahoc } from './../models/khoahoc/khoahoc.entity';
import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from 'typeorm';

@Injectable()
export class KhoahocService {
    constructor(
        @InjectRepository(Khoahoc) private khoahocRepository: Repository<Khoahoc>
    ) { }

    async getAll(): Promise<Khoahoc[]> {
        return await this.khoahocRepository.query(
            "CALL DanhsachKhoaHoc()"
          );
    }

    async getOne(id: string): Promise<Khoahoc> {
        return await this.khoahocRepository.findOne(Number(id)); //Phải convert id sang number vì id của faculty là NUMBER chứ không phải là string
    }

    async getById(id: string): Promise<Khoahoc> {
        return await this.khoahocRepository.findOne(id);
    }

    async add(khoahoc: Khoahoc): Promise<void> {
        //console.log(Khoahoc);
        await this.khoahocRepository.insert(khoahoc);
    }

    async edit(Khoahoc: Khoahoc): Promise<void> {
        await this.khoahocRepository.update(Khoahoc.MaKH, Khoahoc);
    }

    // async delete(Khoahoc: Khoahoc): Promise<void> {
    //     await this.KhoahocRepository.delete(Khoahoc.id);
    // }

    // //CurrentLibrary
    // async getCurrent(): Promise<Khoahoc[]> {
    //     return await this.KhoahocRepository.find({ currentStatus: true });
    // }

    

}
