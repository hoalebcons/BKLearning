import { Hocvien } from './../models/hocvien/hocvien.entity';
import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from 'typeorm';

@Injectable()
export class hocvienService {
    constructor(
        @InjectRepository(Hocvien) private hocvienRepository: Repository<Hocvien>
    ) { }

    async getAll(): Promise<Hocvien[]> {
        return await this.hocvienRepository.find();
    }

    async getOne(id: string , email: string ): Promise<Hocvien> {
        return await this.hocvienRepository.findOne(Number(id)); //Phải convert id sang number vì id của faculty là NUMBER chứ không phải là string
    }

    async getByEmail( email: string): Promise<Hocvien> {
        return await this.hocvienRepository.findOne({Email: email}); 
    }

    async getById(id: string): Promise<Hocvien> {
        return await this.hocvienRepository.findOne(id);
    }

    async add(hocvien: Hocvien): Promise<void> {
        //console.log(hocvien);
        await this.hocvienRepository.insert(hocvien);
    }

    async edit(hocvien: Hocvien): Promise<void> {
        await this.hocvienRepository.update(hocvien.MaHV, hocvien);
    }

    async savedata(hocvien: Hocvien): Promise<void> {
        await this.hocvienRepository.save(hocvien);
    }

    // async delete(hocvien: hocvien): Promise<void> {
    //     await this.hocvienRepository.delete(hocvien.id);
    // }

    // //CurrentLibrary
    // async getCurrent(): Promise<hocvien[]> {
    //     return await this.hocvienRepository.find({ currentStatus: true });
    // }

     

}
