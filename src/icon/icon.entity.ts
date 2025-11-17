import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('icons')
export class Icon {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 100 })
  name: string;

  @Column({ length: 100 })
  icon_key: string;

  @Column({ length: 50, nullable: true })
  category: string;

  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;
}