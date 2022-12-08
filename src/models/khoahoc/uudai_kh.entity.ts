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
  export class Uudai_kh {
  
    @PrimaryColumn()
    Uudai: string;

    @ManyToOne(() => Khoahoc,{ primary: true,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    khoahoc: Khoahoc;
  
  }
  