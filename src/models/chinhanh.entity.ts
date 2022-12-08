import {
    Column,
    CreateDateColumn,
    Entity,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';

  
  @Entity()
  export class Chinhanh {
    @Column("varchar", { primary: true,  length: 255 })
    MaCN: string;
  
    @Column("varchar", { name: "Ten", nullable: true, length: 255 })
    ten: string | null;
  
    @Column("varchar", { name: "Sonha", nullable: true, length: 255 })
    sonha: string | null;
  
    @Column("varchar", { name: "Duong", nullable: true, length: 255 })
    duong: string | null;
  
    @Column("varchar", { name: "Quanhuyen", nullable: true, length: 255 })
    quanhuyen: string | null;
  
    @Column("varchar", { name: "Tinhtp", nullable: true, length: 255 })
    tinhtp: string | null;
  
  }
  