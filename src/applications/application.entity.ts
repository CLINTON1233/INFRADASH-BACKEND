import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

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
}
