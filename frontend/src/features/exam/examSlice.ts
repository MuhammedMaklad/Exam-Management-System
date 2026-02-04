import { createSlice, type PayloadAction } from '@reduxjs/toolkit'

export interface Question {
    id: string
    text: string
    options: string[]
    correctAnswer: string
}

export interface ExamState {
    questions: Question[]
    answers: Record<string, string>
    score: number
    duration: number // in minutes
    isSubmitted: boolean
}

const initialState: ExamState = {
    questions: [],
    answers: {},
    score: 0,
    duration: 0,
    isSubmitted: false,
}

export const examSlice = createSlice({
    name: 'exam',
    initialState,
    reducers: {
        setQuestions: (state, action: PayloadAction<Question[]>) => {
            state.questions = action.payload
            // Reset state when new questions are set
            state.answers = {}
            state.score = 0
            state.isSubmitted = false
        },
        setDuration: (state, action: PayloadAction<number>) => {
            state.duration = action.payload
        },
        setAnswer: (state, action: PayloadAction<{ questionId: string; answer: string }>) => {
            const { questionId, answer } = action.payload
            state.answers[questionId] = answer
        },
        submitExam: (state) => {
            state.isSubmitted = true
            let calculatedScore = 0
            state.questions.forEach((question) => {
                if (state.answers[question.id] === question.correctAnswer) {
                    calculatedScore += 1
                }
            })
            state.score = calculatedScore
        },
        resetExam: (state) => {
            state.questions = []
            state.answers = {}
            state.score = 0
            state.duration = 0
            state.isSubmitted = false
        },
    },
})

export const { setQuestions, setDuration, setAnswer, submitExam, resetExam } = examSlice.actions
export default examSlice.reducer
