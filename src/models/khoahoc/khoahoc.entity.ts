import {
    Column,
    CreateDateColumn,
    Entity,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';

  enum trangthai {
    Male = 'opening',
    Female = 'closed',
  }
  
  @Entity()
  export class Khoahoc {
    @PrimaryColumn()
    MaKH: string;
  
    @Column({ nullable: true })
    Ten: string;
  
    @Column({ nullable: true})
    Hocphi: number;
  
    @Column()
    Noidung: string;
  
    @Column()
    Thoiluong: number;
  
    @Column()
    Trangthai: trangthai;
  
    @Column()
    Gioihansiso: number; 
  
    @Column()
    Yeucautrinhdo: number;

    @Column()
    url: string;

    @Column()
    up: Boolean;
  }
  