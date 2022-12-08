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
import { Giaotrinh } from '../giaotrinh/giaotrinh.entity';
import { Khoahoc } from '../khoahoc/khoahoc.entity';


@Entity()
export class Sudung {
  @ManyToOne((type) => Giaotrinh, { primary: true ,
    onDelete: "CASCADE",
    onUpdate: "CASCADE",})
  @JoinColumn()
  giaotrinh: Giaotrinh;

  @ManyToOne((type) => Khoahoc, { primary: true ,
    onDelete: "CASCADE",
    onUpdate: "CASCADE",}) 
  @JoinColumn()
  khoahoc: Khoahoc;
}
