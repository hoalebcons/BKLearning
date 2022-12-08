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
  export class Giaovien {
    @Column()
    Kinhnghiem: string;

    @OneToOne(type => Nhanvien, { primary: true ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    nhanvien: Nhanvien;
  }
  