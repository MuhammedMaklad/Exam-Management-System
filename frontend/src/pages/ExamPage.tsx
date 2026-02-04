import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
    Button,
    Heading,
    VStack,
    Spinner,
    Container,
    Text,
    Center,
} from '@chakra-ui/react'
import { motion } from 'framer-motion'
import { useAppDispatch, useAppSelector } from '../app/store'
import { setQuestions, setAnswer, submitExam, setDuration } from '../features/exam/examSlice'
import { getExamQuestions, submitExamAnswers } from '../services/examService'
import { QuestionCard } from '../components/QuestionCard'
import { Timer } from '../components/Timer'

export const ExamPage = () => {
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    const dispatch = useAppDispatch()
    const navigate = useNavigate()
    const { questions, answers, isSubmitted } = useAppSelector((state) => state.exam)

    const student = useAppSelector((state) => state.student)

    useEffect(() => {
        const fetchQuestions = async () => {
            if (!student.courseId) return
            setLoading(true)
            setError(null)
            try {
                const { questions: data, duration } = await getExamQuestions(student.courseId)
                dispatch(setQuestions(data))
                dispatch(setDuration(duration))
            } catch (err) {
                console.error('Failed to fetch questions', err)
                setError('Failed to load exam questions. Please try again.')
            } finally {
                setLoading(false)
            }
        }

        if (questions.length === 0) {
            fetchQuestions()
        } else {
            setLoading(false)
        }
    }, [dispatch, questions.length])

    const handleRetry = async () => {
        if (!student.courseId) return
        setLoading(true)
        setError(null)
        try {
            const { questions: data, duration } = await getExamQuestions(student.courseId)
            dispatch(setQuestions(data))
            dispatch(setDuration(duration))
        } catch (err) {
            console.error('Failed to retry questions', err)
            setError('Failed to load exam questions. Please check your connection and try again.')
        } finally {
            setLoading(false)
        }
    }

    // Warn on page refresh/leave
    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (!isSubmitted) {
                e.preventDefault()
            }
        }

        window.addEventListener('beforeunload', handleBeforeUnload)
        return () => window.removeEventListener('beforeunload', handleBeforeUnload)
    }, [isSubmitted])

    const handleAnswerChange = (questionId: string, value: string) => {
        if (isSubmitted) return
        dispatch(setAnswer({ questionId, answer: value }))
    }

    const handleSubmit = async () => {
        // Prepare answers array for the API (mapping to { questionId, answer })
        const answersArray = questions.map((q) => {
            const selectedAnswerText = answers[q.id]
            const index = q.options.indexOf(selectedAnswerText)
            const alphabeticAnswer = index !== -1 ? String.fromCharCode(65 + index) : ''

            return {
                questionId: Number(q.id),
                answer: alphabeticAnswer
            }
        })

        await submitExamAnswers(
            8, // hardcoded exam ID as per project context
            `${student.firstName} ${student.lastName}`,
            answersArray
        )

        dispatch(submitExam())
        navigate('/result')
    }

    if (loading) {
        return (
            <Center height="100vh">
                <VStack gap={4}>
                    <Spinner size="xl" />
                    <Text>Loading Exam...</Text>
                </VStack>
            </Center>
        )
    }

    if (error) {
        return (
            <Center height="100vh">
                <VStack gap={4}>
                    <Text color="red.500" fontSize="lg">{error}</Text>
                    <Button onClick={handleRetry} colorPalette="blue">Retry</Button>
                </VStack>
            </Center>
        )
    }

    return (
        <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 0.5 }}>
            <Container maxW="container.md" py={10}>
                <Timer />
                <VStack gap={8} align="stretch" mt={4}>
                    <Heading textAlign="center">Exam in Progress</Heading>
                    {questions.map((q, index) => (
                        <QuestionCard
                            key={q.id}
                            question={q}
                            index={index}
                            selectedAnswer={answers[q.id] || ''}
                            onAnswerSelect={(value) => handleAnswerChange(q.id, value)}
                            disabled={isSubmitted}
                        />
                    ))}
                    <Button
                        onClick={handleSubmit}
                        colorPalette="blue"
                        size="lg"
                        mt={4}
                        disabled={isSubmitted}
                    >
                        {isSubmitted ? 'Exam Submitted' : 'Submit Exam'}
                    </Button>
                </VStack>
            </Container>
        </motion.div>
    )
}
