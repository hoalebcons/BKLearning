import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToOne,
    OneToOne,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';
import { Khoahoc } from './khoahoc.entity';
  
  @Entity()
  export class Khoathieunhi {
  
    @OneToOne(type => Khoahoc, { primary: true ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    khoahoc: Khoahoc;
  
  }
  