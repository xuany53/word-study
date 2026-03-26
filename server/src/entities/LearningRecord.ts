import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
  JoinColumn,
  Index
} from 'typeorm'
import { User } from './User'

@Entity('learning_records')
@Index(['userId', 'wordId'])
export class LearningRecord {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ type: 'varchar' })
  userId: string

  @Column({ type: 'varchar' })
  wordId: string

  @Column({ type: 'varchar', default: 'new' })
  status: string

  @Column({ type: 'int', default: 0 })
  masteryLevel: number

  @Column({ type: 'int', default: 0 })
  correctCount: number

  @Column({ type: 'int', default: 0 })
  wrongCount: number

  @Column({ type: 'datetime' })
  nextReviewAt: Date

  @Column({ type: 'datetime', nullable: true })
  lastReviewAt: Date | null

  @CreateDateColumn()
  createdAt: Date

  @UpdateDateColumn()
  updatedAt: Date

  @ManyToOne(() => User, (user) => user.learningRecords)
  @JoinColumn({ name: 'userId' })
  user: User
}