import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  ManyToOne,
  JoinColumn
} from 'typeorm'
import { User } from './User'

@Entity('user_badges')
export class UserBadge {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ type: 'varchar' })
  userId: string

  @Column({ type: 'varchar' })
  badgeId: string

  @Column({ type: 'datetime' })
  unlockedAt: Date

  @ManyToOne(() => User, (user) => user.userBadges)
  @JoinColumn({ name: 'userId' })
  user: User
}