import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn
} from 'typeorm'

@Entity('badges')
export class Badge {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ type: 'varchar' })
  name: string

  @Column({ type: 'varchar' })
  icon: string

  @Column({ type: 'text' })
  description: string

  @Column({ type: 'varchar', default: 'common' })
  rarity: string

  @Column({ type: 'json' })
  unlockCondition: {
    type: string
    value: number
  }

  @CreateDateColumn()
  createdAt: Date
}