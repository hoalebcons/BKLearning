import { Lophoc } from './lophoc.entity';
import {

  Column,
    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryColumn,
  } from 'typeorm';


  @Entity()
  export class Thoikhoabieu_lh {
    
    @Column("enum", {
      primary: true,
      name: "Ngay",
      enum: ["2", "3", "4", "5", "6", "7", "8"],
    })
    Ngay: "2" | "3" | "4" | "5" | "6" | "7" | "8";

    @PrimaryColumn()
    Giobatdau: number;
  
    @PrimaryColumn()
    Gioketthuc: number;

    @ManyToOne(() => Lophoc, {primary: true,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    lophoc: Lophoc;
  
  }
  