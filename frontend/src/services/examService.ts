import axios from 'axios'
import { type Question } from '../features/exam/examSlice'
import { type ExamData, type ExamApiResponse } from './types'

const BASE_URL = 'http://localhost:5261'

export const getExamQuestions = async (
    courseId: number
): Promise<ExamData> => {
    try {
        const response = await axios.get<ExamApiResponse>(`${BASE_URL}/api/exams/${courseId}`)

        const data = response.data

        // Map external API data to our internal Question format
        const mappedQuestions: Question[] = data.questions.map((item) => {
            let correctAnswerText = item.questionAnswer

            // If it's multiple choice (A, B, C, D), map to the choice text
            if (['A', 'B', 'C', 'D'].includes(item.questionAnswer)) {
                const index = item.questionAnswer.charCodeAt(0) - 65 // A=0, B=1...
                correctAnswerText = item.choices[index] || item.questionAnswer
            }

            return {
                id: item.questionId.toString(),
                text: item.questionText,
                options: item.choices,
                correctAnswer: correctAnswerText,
            }
        })

        return {
            questions: mappedQuestions,
            duration: data.duration
        }
    } catch (error) {
        console.error('Error fetching exam questions:', error)
        throw error
    }
}

export const generateExam = async (courseId: number, mcqCount: number, tfCount: number): Promise<boolean> => {
    try {
        const payload = {
            CourseId: courseId,
            McqQuestions: mcqCount,
            TfQuestions: tfCount
        }
        const response = await axios.post(`${BASE_URL}/api/exams/generate`, payload)
        return response.status === 200
    } catch (error) {
        console.error('Failed to generate exam:', error)
        return false
    }
}

export const submitExamAnswers = async (
    examId: number,
    studentFullName: string,
    answers: { questionId: number; answer: string }[]
): Promise<boolean> => {
    try {
        const payload = {
            studentFullName,
            answers
        }
        const response = await axios.post(`${BASE_URL}/api/exams/${examId}/answers`, payload)
        return response.status === 200
    } catch (error) {
        console.error('Failed to submit exam answers:', error)
        return false
    }
}
