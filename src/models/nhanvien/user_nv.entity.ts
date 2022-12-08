import { Nhanvien } from './nhanvien.entity';
import { Column, Entity, Index, JoinColumn, ManyToOne, OneToOne, PrimaryColumn } from 'typeorm';

@Entity()
export class user_nv {
  @PrimaryColumn()
  username: string;

  @Column()
  password: string;

  @Column()
  role: number;

  @OneToOne(() => Nhanvien, { 
    onDelete: "CASCADE",
    onUpdate: "CASCADE",})
  @Index({ unique: true })
  @JoinColumn()
  nhanvien: Nhanvien;
}
