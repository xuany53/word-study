import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn
} from 'typeorm'

@Entity('words')
export class Word {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ type: 'varchar' })
  word: string

  @Column({ type: 'varchar' })
  phonetic: string

  @Column({ type: 'varchar', nullable: true })
  pronunciation: string

  @Column({ type: 'json' })
  meanings: Array<{
    partOfSpeech: string
    definition: string
    translation: string
  }>

  @Column({ type: 'json' })
  examples: Array<{
    sentence: string
    translation: string
  }>

  @Column({ type: 'varchar', nullable: true })
  image: string

  @Column({ type: 'varchar', nullable: true })
  category: string

  @Column({ type: 'varchar', nullable: true })
  gradeLevel: string // 小学/初中/高中

  @Column({ type: 'int', default: 1 })
  difficulty: number

  @CreateDateColumn()
  createdAt: Date
}