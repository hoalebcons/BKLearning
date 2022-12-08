import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';
import { Khoahoc } from './khoahoc.entity';
  
  @Entity()
  export class Doituong_kh {
  
    @PrimaryColumn()
    Doituong: string;

    @ManyToOne(() => Khoahoc,{ primary: true,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    khoahoc: Khoahoc;
  
  }
  