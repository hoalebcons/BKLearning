import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';
import { Khoakynang } from './khoakynang.entity';
  
  @Entity()
  export class Kynang_kkn {
  
    @PrimaryColumn()
    Kynang: string;

    @ManyToOne(() => Khoakynang , { primary: true ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    khoakynang: Khoakynang;
  
  }
  