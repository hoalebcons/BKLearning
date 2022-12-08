import {
    Column,
    CreateDateColumn,
    Entity,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';

  
  @Entity()
  export class Giaotrinh {
    @Column("varchar", { primary: true, name: "MaGT", length: 255 })
    maGt: string;
  
    @Column("varchar", { name: "Ten", length: 255 })
    ten: string;
  
    @Column({ nullable: true })
    Namxuatban: number;
  
  }
  