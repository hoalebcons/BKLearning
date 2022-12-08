import { Giaovien } from './../nhanvien/giaovien.entity';
import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToMany,
    ManyToOne,
    PrimaryColumn,
    UpdateDateColumn,
  } from 'typeorm';
import { Lophoc } from '../lophoc/lophoc.entity';

  
  @Entity()
  export class Giangday {
    
    @ManyToOne(type => Lophoc, { primary: true ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    lophoc: Lophoc;
  
    @ManyToOne(type => Giaovien, { primary: true ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",})
    @JoinColumn()
    giaovien: Giaovien;
  }

