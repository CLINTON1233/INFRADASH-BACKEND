import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { Category } from '../category/category.entity';

@Entity('applications')
export class Application {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 100 })
  title: string;

  @Column({ length: 255 })
  fullName: string;

  @Column({ length: 255 })
  url: string;

  @Column({ length: 50 })
  icon: string;

  @ManyToOne(() => Category, category => category.applications, { 
    eager: true,
    nullable: false 
  })
  @JoinColumn({ name: 'categoryId' })
  category: Category;

  @Column()
  categoryId: number;

  // TAMBAHKAN FIELD STATUS UNTUK SOFT DELETE
  @Column({ default: 1 }) // 1 = active, 0 = deleted
  status: number;
}