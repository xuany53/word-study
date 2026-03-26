import type { Word } from '@/types/word'

/**
 * Word Service - Handles word-related business logic
 * Provides methods for word selection, option generation, and filtering
 */
export const wordService = {
  /**
   * Generate multiple choice options for a word
   * @param correctWord - The correct word
   * @param allWords - Pool of all available words
   * @param count - Number of options to generate (default: 4)
   * @returns Array of options including the correct answer
   */
  generateOptions(correctWord: Word, allWords: Word[], count: number = 4): string[] {
    // Filter out the correct word and words with same spelling
    const otherWords = allWords.filter(
      (w) => w.id !== correctWord.id && w.word !== correctWord.word
    )

    // Shuffle and take (count - 1) wrong options
    const shuffled = [...otherWords].sort(() => Math.random() - 0.5)
    const wrongOptions = shuffled.slice(0, count - 1).map((w) => w.word)

    // Combine with correct answer and shuffle
    const allOptions = [correctWord.word, ...wrongOptions]
    return allOptions.sort(() => Math.random() - 0.5)
  },

  /**
   * Get random words from a pool
   * @param words - Pool of words
   * @param count - Number of words to select
   * @param exclude - IDs to exclude
   * @returns Random selection of words
   */
  getRandomWords(words: Word[], count: number, exclude: string[] = []): Word[] {
    const filtered = words.filter((w) => !exclude.includes(w.id))
    const shuffled = [...filtered].sort(() => Math.random() - 0.5)
    return shuffled.slice(0, count)
  },

  /**
   * Get words by difficulty level
   * @param words - Pool of words
   * @param difficulty - Target difficulty (1-5)
   * @returns Words matching the difficulty
   */
  getWordsByDifficulty(words: Word[], difficulty: number): Word[] {
    return words.filter((w) => w.difficulty === difficulty)
  },

  /**
   * Calculate mastery level based on Ebbinghaus curve
   * @param currentLevel - Current mastery level (0-5)
   * @param isCorrect - Whether the answer was correct
   * @returns New mastery level
   */
  calculateMasteryLevel(currentLevel: number, isCorrect: boolean): number {
    if (isCorrect) {
      return Math.min(5, currentLevel + 1)
    } else {
      return Math.max(0, currentLevel - 1)
    }
  },

  /**
   * Get review interval in days based on mastery level
   * Ebbinghaus curve: 1, 2, 4, 7, 15, 30 days
   * @param masteryLevel - Current mastery level (0-5)
   * @returns Number of days until next review
   */
  getReviewInterval(masteryLevel: number): number {
    const intervals = [1, 2, 4, 7, 15, 30]
    return intervals[masteryLevel] || 1
  },

  /**
   * Check if a word needs review today
   * @param nextReviewAt - The scheduled review date
   * @returns Whether the word should be reviewed
   */
  needsReview(nextReviewAt: Date | string): boolean {
    const reviewDate = new Date(nextReviewAt)
    return reviewDate <= new Date()
  }
}

export default wordService