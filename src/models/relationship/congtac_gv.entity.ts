import { Chinhanh } from './../chinhanh.entity';
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

@Entity()
export class congtac_gv {
  @ManyToOne((type) => Giaovien, { primary: true ,
    onDelete: "CASCADE",
    onUpdate: "CASCADE",})
  @JoinColumn()
  giaovien: Giaovien;

  @ManyToOne((type) => Chinhanh, { primary: true,
    onDelete: "CASCADE",
    onUpdate: "CASCADE",})
  @JoinColumn()
  chinhanh: Chinhanh;
}
