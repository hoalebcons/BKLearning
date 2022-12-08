
import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';
import { Khoathieunien } from './khoathieunien.entity';
  @Entity()
  export class Kynangsong_ktnien {
  
    @PrimaryColumn()
    Kynangsong: string;

    @ManyToOne(() => Khoathieunien,{ primary: true,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn() 
    khoathieunien: Khoathieunien;
   
  }
  