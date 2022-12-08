import {
    Column,
    CreateDateColumn,
    Entity,
    Index,
    JoinColumn,
    OneToOne,
    PrimaryColumn,
    Unique,
    UpdateDateColumn,
  } from 'typeorm';
  enum Gender {
    Male,
    Female
  }

  @Entity()
  export class Hocvien {
    @PrimaryColumn()
    MaHV: string;
  
    @Column({ nullable: true })
    Ho: string;
  
    @Column({ nullable: true })
    Tendem: string;
  
    @Column({ nullable: true })
    Ten: string;
  
    @Column("enum", {
      name: "Gioitinh",
      nullable: true,
      enum: ["male", "female"],
    })
    gioitinh: "male" | "female" | null;

    @Column({ nullable: false })
    @Index({ unique: true })
    Email: string;

    @Column({ nullable: true })
    Namsinh: number;

    @Column({ nullable: true })
    Sonha: string;

    @Column({ nullable: true })
    Duong: string;
  
    @Column({ nullable: true })
    Quanhuyen: string;
  
    @Column({ nullable: true })
    Tinhtp: string;

    @Column({ nullable: true  })
    Sodienthoai: number;

    @Column({ nullable: true })
    password: string;
  }
  