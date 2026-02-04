import { type Question } from '../features/exam/examSlice'

// Types for the Local Exam API response
export interface ApiQuestion {
    questionId: number
    questionText: string
    questionAnswer: string
    questionGrade: number
    choices: string[]
}

export interface ExamApiResponse {
    examId: number
    examName: string
    duration: number
    questions: ApiQuestion[]
}

export interface ExamData {
    questions: Question[]
    duration: number
}

export interface Track {
    id: number
    name: string
}

export interface Course {
    id: number
    name: string
}

export interface AuthData {
    firstName: string
    lastName: string
    trackId: number
    courseId: number
}
