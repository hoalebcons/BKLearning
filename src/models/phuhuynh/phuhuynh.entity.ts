import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    OneToOne,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';
import { Hocvien } from '../hocvien/hocvien.entity';


  @Entity()
  export class Phuhuynh {

    @OneToOne(() => Hocvien, { primary: true,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    hocvien: Hocvien;

    @PrimaryColumn()
    Tenphuhuynh: string;
  
    @Column("int", { name: "Namsinh", nullable: true })
    namsinh: number | null;

    @Column("enum", {
      name: "Gioitinh",
      nullable: true,
      enum: ["male", "female"],
    })
    gioitinh: "male" | "female" | null;

    @Column("varchar", { name: "Email", nullable: true, length: 255 })
    email: string | null;
  
    @Column("varchar", { name: "Quanhe", nullable: true, length: 255 })
    quanhe: string | null;

    @Column("int", { name: "Sodienthoai", nullable: true })
    sodienthoai: number | null;
  }
  