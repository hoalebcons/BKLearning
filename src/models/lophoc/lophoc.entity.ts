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
import { Chinhanh } from '../chinhanh.entity';
import { Khoahoc } from '../khoahoc/khoahoc.entity';

  @Entity()
  export class Lophoc {
    @PrimaryColumn()
    MaLH: string;
  
    @Column({ nullable: true })
    Ngaybatdau: Date;
  
    @Column({ nullable: true })
    Ngayketthuc: Date;
  
    @Column()
    Siso: number;
  
    @ManyToOne(() => Chinhanh,{ nullable: false ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    chinhanh: Chinhanh;

    @ManyToOne(() => Khoahoc,{ nullable: false ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    khoahoc: Khoahoc;
  }
  