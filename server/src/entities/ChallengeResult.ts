import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  ManyToOne,
  JoinColumn
} from 'typeorm'
import { User } from './User'

@Entity('challenge_results')
export class ChallengeResult {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ type: 'varchar' })
  userId: string

  @Column({ type: 'varchar' })
  levelId: string

  @Column({ type: 'int' })
  correctCount: number

  @Column({ type: 'int' })
  wrongCount: number

  @Column({ type: 'int' })
  timeTaken: number

  @Column({ type: 'int', default: 0 })
  starRating: number

  @Column({ type: 'int' })
  xpEarned: number

  @Column({ type: 'boolean', default: false })
  isPassed: boolean

  @CreateDateColumn()
  completedAt: Date

  @ManyToOne(() => User)
  @JoinColumn({ name: 'userId' })
  user: User
}