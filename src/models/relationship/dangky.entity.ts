import { Lophoc } from './../lophoc/lophoc.entity';
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
import { Hocvien } from '../hocvien/hocvien.entity';

@Entity()
export class Dangky {
  @ManyToOne((type) => Lophoc, { primary: true ,
    onDelete: "CASCADE",
    onUpdate: "CASCADE",})
  @JoinColumn()
  lophoc: Lophoc;

  @ManyToOne((type) => Hocvien, { primary: true,
    onDelete: "CASCADE",
    onUpdate: "CASCADE", })
  @JoinColumn()
  hocvien: Hocvien;

  @Column()
  Ngaydangky: Date;
}
