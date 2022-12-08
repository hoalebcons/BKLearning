import {

    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryColumn,
  } from 'typeorm';
import { Hocvien } from './hocvien.entity';


   
  @Entity()
  export class trinhdo_hv {
    @PrimaryColumn()
    Diem: number;
  
    @PrimaryColumn()
    Ngaycapnhat: Date;

    @ManyToOne(() => Hocvien, { primary: true ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",
    })
    @JoinColumn()
    hocvien: Hocvien;
  
  }
  