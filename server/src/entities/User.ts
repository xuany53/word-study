import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  OneToMany
} from 'typeorm'
import { LearningRecord } from './LearningRecord'
import { UserBadge } from './UserBadge'

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ type: 'varchar', unique: true })
  username: string

  @Column({ type: 'varchar', unique: true })
  email: string

  @Column({ type: 'varchar' })
  password: string

  @Column({ type: 'varchar', default: 'light' })
  theme: string

  @Column({ type: 'int', default: 20 })
  dailyNewWords: number

  @Column({ type: 'varchar', default: 'choice' })
  learningMode: string

  @Column({ type: 'boolean', default: true })
  soundEnabled: boolean

  @Column({ type: 'boolean', default: true })
  autoPlayAudio: boolean

  @Column({ type: 'int', default: 1 })
  level: number

  @Column({ type: 'int', default: 0 })
  xp: number

  @Column({ type: 'int', default: 0 })
  streak: number

  @Column({ type: 'int', default: 0 })
  longestStreak: number

  @Column({ type: 'date', nullable: true })
  lastCheckIn: Date | null

  @CreateDateColumn()
  createdAt: Date

  @UpdateDateColumn()
  updatedAt: Date

  @OneToMany(() => LearningRecord, (record) => record.user)
  learningRecords: LearningRecord[]

  @OneToMany(() => UserBadge, (userBadge) => userBadge.user)
  userBadges: UserBadge[]
}