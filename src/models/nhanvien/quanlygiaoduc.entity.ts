import { Nhanvien } from './nhanvien.entity';
import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    OneToOne,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';


  @Entity()
  export class Quanlygiaoduc {

    @OneToOne(type => Nhanvien, { primary: true ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    nhanvien: Nhanvien;
  }
  