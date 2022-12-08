import {

    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryColumn,
  } from 'typeorm';
import { Giaotrinh } from './giaotrinh.entity';

  
  @Entity()
  export class tacgia_gt {
    @PrimaryColumn()
    Tacgia: string;
  
    @ManyToOne(() => Giaotrinh, {primary: true ,
      onDelete: "CASCADE",
      onUpdate: "CASCADE",
    })
    @JoinColumn()
    giaotrinh: Giaotrinh;
  
  }
  