import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
} from 'typeorm';

@Entity()
export class user {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 100, nullable: true })
  nama: string;

  @Column({ unique: true })
  email: string;

  @Column()
  password: string;

  @Column({ nullable: true })
  badge: string;

  @Column({ nullable: true })
  telp: string;

  @Column({ nullable: true })
  departemen: string;

  @Column({ default: 'admin' })
  role: string;

  @CreateDateColumn()
  created_at: Date;
}
