import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  OneToOne,
  PrimaryColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity()
export class Nhanvien {
  @PrimaryColumn()
  MaNV: string;

  @Column()
  Ho: string;

  @Column()
  Tendem: string;

  @Column()
  Ten: string;

  @Column({ nullable: true })
  Namsinh: number;

  @Column("enum", {
    name: "Gioitinh",
    nullable: true,
    enum: ["male", "female"],
  })
  Gioitinh: "male" | "female" | null;

  @Column("varchar", { name: "Email", length: 255 })
  email: string | null;

  @Column("int", { name: "Sodienthoai", nullable: true })
  Sodienthoai: number | null;
}
