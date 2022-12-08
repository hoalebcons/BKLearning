import { Trogiang } from './trogiang.entity';
import { Entity, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';

@Entity()
export class Trinhdo_tg {
  @PrimaryColumn()
  trinhdo: number;

  @ManyToOne(() => Trogiang , { primary: true,
    onDelete: "CASCADE",
    onUpdate: "CASCADE",})
  @JoinColumn()
  trogiang: Trogiang;
}
