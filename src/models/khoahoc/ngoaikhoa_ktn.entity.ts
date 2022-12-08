import { Khoathieunhi } from './khoathieunhi.entity';
import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';
  
  @Entity()
  export class ngoaikhoa_ktnhi {
  
    @PrimaryColumn()
    Ngoaikhoa: string;

    @ManyToOne(() => Khoathieunhi, { primary: true,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    khoathieunhi: Khoathieunhi;
  
  }
  