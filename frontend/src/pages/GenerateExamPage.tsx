import { useState, useEffect } from 'react'
import {
    Box,
    Button,
    Heading,
    VStack,
    Text,
    Input,
    NativeSelect,
    Alert,
} from '@chakra-ui/react'
import { motion } from 'framer-motion'
import { getCourses } from '../services/courseService'
import { generateExam } from '../services/examService'
import { type Course } from '../services/types'
import { Navbar } from '../components/Navbar'

export const GenerateExamPage = () => {
    const [courses, setCourses] = useState<Course[]>([])
    const [selectedCourseId, setSelectedCourseId] = useState('')
    const [mcqCount, setMcqCount] = useState<number>(0)
    const [tfCount, setTfCount] = useState<number>(0)
    const [loading, setLoading] = useState(false)
    const [message, setMessage] = useState<{ text: string, type: 'info' | 'error' | 'success' } | null>(null)

    useEffect(() => {
        const fetchCourses = async () => {
            try {
                const data = await getCourses()
                setCourses(data)
            } catch (err) {
                console.error('Failed to fetch courses:', err)
            }
        }
        fetchCourses()
    }, [])

    const handleGenerate = async () => {
        if (!selectedCourseId) {
            setMessage({ text: 'Please select a course', type: 'error' })
            return
        }

        if (mcqCount + tfCount !== 10) {
            setMessage({ text: 'Total questions (MCQ + T/F) must be exactly 10', type: 'error' })
            return
        }

        setLoading(true)
        setMessage(null)

        try {
            console.log(selectedCourseId, mcqCount, tfCount);
            const success = await generateExam(Number(selectedCourseId), mcqCount, tfCount)
            if (success) {
                setMessage({ text: 'Exam generated successfully!', type: 'success' })
            } else {
                setMessage({ text: 'Failed to generate exam. Please try again.', type: 'error' })
            }
        } catch (err) {
            setMessage({ text: 'An error occurred while generating the exam.', type: 'error' })
        } finally {
            setLoading(false)
        }
    }

    return (
        <Box>
            <Navbar />
            <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.5 }}>
                <Box maxW="500px" mx="auto" mt={10} p={10} borderWidth={1} borderRadius="lg" boxShadow="lg" bg="white">
                    <VStack gap={6} align="stretch">
                        <Heading fontSize="2xl" textAlign="center" color="blue.600">
                            Generate New Exam
                        </Heading>

                        <Box>
                            <Text mb={2} fontWeight="bold">Select Course</Text>
                            <NativeSelect.Root>
                                <NativeSelect.Field
                                    placeholder="Select Course"
                                    value={selectedCourseId}
                                    onChange={(e) => setSelectedCourseId(e.target.value)}
                                >
                                    {courses.map((c) => (
                                        <option key={c.id} value={c.id}>
                                            {c.name}
                                        </option>
                                    ))}
                                </NativeSelect.Field>
                            </NativeSelect.Root>
                        </Box>

                        <Box>
                            <Text mb={2} fontWeight="bold">Number of MCQ Questions</Text>
                            <Input
                                type="number"
                                placeholder="Enter MCQ count"
                                value={mcqCount}
                                onChange={(e) => setMcqCount(Number(e.target.value))}
                                min={0}
                                max={10}
                            />
                        </Box>

                        <Box>
                            <Text mb={2} fontWeight="bold">Number of T/F Questions</Text>
                            <Input
                                type="number"
                                placeholder="Enter T/F count"
                                value={tfCount}
                                onChange={(e) => setTfCount(Number(e.target.value))}
                                min={0}
                                max={10}
                            />
                        </Box>

                        {message && (
                            <Alert.Root status={message.type === 'error' ? 'error' : 'success'}>
                                <Alert.Indicator />
                                <Alert.Content>
                                    <Alert.Title>{message.text}</Alert.Title>
                                </Alert.Content>
                            </Alert.Root>
                        )}

                        <Button
                            colorPalette="blue"
                            size="lg"
                            onClick={handleGenerate}
                            loading={loading}
                            loadingText="Generating..."
                        >
                            Generate Exam
                        </Button>
                    </VStack>
                </Box>
            </motion.div>
        </Box>
    )
}
