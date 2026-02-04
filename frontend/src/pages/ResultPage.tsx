import { useNavigate } from 'react-router-dom'
import {
    Box,
    Button,
    Heading,
    VStack,
    Text,
    Container,
    Card,
    Separator,
    Stack,
} from '@chakra-ui/react'
import { motion } from 'framer-motion'
import { useAppDispatch, useAppSelector } from '../app/store'
import { resetExam } from '../features/exam/examSlice'

export const ResultPage = () => {
    const dispatch = useAppDispatch()
    const navigate = useNavigate()

    const { score, questions, answers } = useAppSelector((state) => state.exam)
    const { firstName, lastName, trackName, courseName } = useAppSelector((state) => state.student)

    const totalQuestions = questions.length
    const percentage = totalQuestions > 0 ? (score / totalQuestions) * 100 : 0
    const isPassed = percentage >= 50

    const handleRestart = () => {
        dispatch(resetExam())
        navigate('/setup')
    }

    return (
        <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 0.5 }}>
            <Container maxW="container.md" py={10}>
                <Card.Root>
                    <Card.Body>
                        <VStack gap={6} align="stretch" textAlign="center">
                            <Heading size="3xl" color={isPassed ? 'green.500' : 'red.500'}>
                                {isPassed ? 'Passed!' : 'Failed'}
                            </Heading>

                            <Box>
                                <Text fontSize="xl" fontWeight="bold">{firstName} {lastName}</Text>
                                <Text color="fg.muted">{trackName} - {courseName}</Text>
                            </Box>

                            <Box p={6} bg="bg.subtle" borderRadius="md">
                                <Text fontSize="4xl" fontWeight="bold">
                                    {score} / {totalQuestions}
                                </Text>
                                <Text fontSize="lg">Score ({percentage.toFixed(0)}%)</Text>
                            </Box>

                            <Separator />

                            <VStack gap={4} align="stretch" textAlign="left">
                                <Heading size="lg">Review</Heading>
                                {questions.map((q, index) => {
                                    const studentAnswer = answers[q.id]
                                    const isCorrect = studentAnswer === q.correctAnswer

                                    return (
                                        <Box
                                            key={q.id}
                                            p={4}
                                            borderWidth={1}
                                            borderRadius="md"
                                            borderColor={isCorrect ? 'green.500' : 'red.500'}
                                            bg={isCorrect ? 'green.50' : 'red.50'}
                                        >
                                            <Text fontWeight="bold" mb={2}>
                                                {index + 1}. {q.text}
                                            </Text>
                                            <Stack gap={1}>
                                                <Text color={isCorrect ? 'green.700' : 'red.700'}>
                                                    Your Answer: <Text as="span" fontWeight="semibold">{studentAnswer || 'Skipped'}</Text>
                                                </Text>
                                                {!isCorrect && (
                                                    <Text color="green.700">
                                                        Correct Answer: <Text as="span" fontWeight="semibold">{q.correctAnswer}</Text>
                                                    </Text>
                                                )}
                                            </Stack>
                                        </Box>
                                    )
                                })}
                            </VStack>

                            <Separator />

                            <Button onClick={handleRestart} colorPalette="blue" size="lg">
                                Restart Exam
                            </Button>
                        </VStack>
                    </Card.Body>
                </Card.Root>
            </Container>
        </motion.div>
    )
}
