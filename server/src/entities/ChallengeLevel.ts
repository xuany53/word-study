import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn
} from 'typeorm'

@Entity('challenge_levels')
export class ChallengeLevel {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ type: 'varchar' })
  name: string

  @Column({ type: 'text' })
  description: string

  @Column({ type: 'int' })
  wordCount: number

  @Column({ type: 'int', nullable: true })
  timeLimit: number | null

  @Column({ type: 'int' })
  maxErrors: number

  @Column({ type: 'varchar', default: 'easy' })
  difficulty: string

  @Column({ type: 'int' })
  xpReward: number

  @Column({ type: 'varchar', nullable: true })
  prerequisiteLevelId: string | null

  @CreateDateColumn()
  createdAt: Date
}