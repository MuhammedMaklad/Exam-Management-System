import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
    Box,
    Button,
    Heading,
    Input,
    VStack,
    Text,
    Stack,
    NativeSelect,
} from '@chakra-ui/react'
import { motion } from 'framer-motion'
import { useAppDispatch } from '../app/store'
import { setStudentInfo, clearStudentInfo } from '../features/student/studentSlice'
import { ExamRulesDialog } from '../components/ExamRulesDialog'
import { getTracks, getTrackCourses } from '../services/courseService'
import { authenticateStudent } from '../services/studentService'
import { type Track, type Course } from '../services/types'
import { useEffect } from 'react'
import { Navbar } from '../components/Navbar'

export const SetupPage = () => {
    const [firstName, setFirstName] = useState('')
    const [lastName, setLastName] = useState('')
    const [trackId, setTrackId] = useState<string>('')
    const [courseId, setCourseId] = useState<string>('')
    const [tracks, setTracks] = useState<Track[]>([])
    const [courses, setCourses] = useState<Course[]>([])
    const [isDialogOpen, setIsDialogOpen] = useState(false)
    const [errors, setErrors] = useState(false)
    const [authError, setAuthError] = useState(false)

    const dispatch = useAppDispatch()
    const navigate = useNavigate()

    useEffect(() => {
        const fetchTracks = async () => {
            try {
                const tracksData = await getTracks()
                setTracks(tracksData)
            } catch (err) {
                console.error('Failed to fetch tracks:', err)
            }
        }
        fetchTracks()
    }, [])

    useEffect(() => {
        const fetchCourses = async () => {
            if (trackId) {
                try {
                    const coursesData = await getTrackCourses(Number(trackId))
                    setCourses(coursesData)
                } catch (err) {
                    console.error('Failed to fetch courses:', err)
                    setCourses([])
                }
            } else {
                setCourses([])
            }
        }
        fetchCourses()
    }, [trackId])

    const handleStartExam = async () => {
        if (!firstName || !lastName || !trackId || !courseId) {
            setErrors(true)
            return
        }
        setErrors(false)
        setAuthError(false)

        const isValid = await authenticateStudent({
            firstName,
            lastName,
            trackId: Number(trackId),
            courseId: Number(courseId)
        })

        if (isValid) {
            setIsDialogOpen(true)
        } else {
            setAuthError(true)
        }
    }

    const handleClear = () => {
        setFirstName('')
        setLastName('')
        setTrackId('')
        setCourseId('')
        setErrors(false)
        setAuthError(false)
        dispatch(clearStudentInfo())
    }

    const handleConfirmStart = () => {
        const selectedTrack = tracks.find(t => t.id === Number(trackId))
        const selectedCourse = courses.find(c => c.id === Number(courseId))

        dispatch(setStudentInfo({
            firstName,
            lastName,
            trackId: Number(trackId),
            trackName: selectedTrack?.name || '',
            courseId: Number(courseId),
            courseName: selectedCourse?.name || '',
        }))
        setIsDialogOpen(false)
        navigate('/exam')
    }

    return (
        <Box>
            <Navbar />
            <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.5 }}>
                <Box maxW="500px" mx="auto" mt={10} p={5} borderWidth={1} borderRadius="lg" boxShadow="lg">
                    <VStack gap={4} align="stretch">
                        <Heading fontSize="2xl" textAlign="center">
                            Exam Setup
                        </Heading>

                        <Box>
                            <Stack direction="row" gap={4}>
                                <Box flex={1}>
                                    <Text mb={2} fontWeight="bold">
                                        First Name
                                    </Text>
                                    <Input
                                        placeholder="First Name"
                                        value={firstName}
                                        onChange={(e) => setFirstName(e.target.value)}
                                        borderColor={errors && !firstName ? 'red.500' : undefined}
                                    />
                                </Box>
                                <Box flex={1}>
                                    <Text mb={2} fontWeight="bold">
                                        Last Name
                                    </Text>
                                    <Input
                                        placeholder="Last Name"
                                        value={lastName}
                                        onChange={(e) => setLastName(e.target.value)}
                                        borderColor={errors && !lastName ? 'red.500' : undefined}
                                    />
                                </Box>
                            </Stack>
                        </Box>

                        <Box>
                            <Text mb={2} fontWeight="bold">
                                Track Name
                            </Text>
                            <NativeSelect.Root>
                                <NativeSelect.Field
                                    placeholder="Select Track"
                                    value={trackId}
                                    onChange={(e) => setTrackId(e.target.value)}
                                    borderColor={errors && !trackId ? 'red.500' : undefined}
                                >
                                    {tracks.map((t) => (
                                        <option key={t.id} value={t.id}>
                                            {t.name}
                                        </option>
                                    ))}
                                </NativeSelect.Field>
                            </NativeSelect.Root>
                        </Box>

                        <Box>
                            <Text mb={2} fontWeight="bold">
                                Course
                            </Text>
                            <NativeSelect.Root disabled={!trackId}>
                                <NativeSelect.Field
                                    placeholder="Select Course"
                                    value={courseId}
                                    onChange={(e) => setCourseId(e.target.value)}
                                    borderColor={errors && !courseId ? 'red.500' : undefined}
                                >
                                    {courses.map((c) => (
                                        <option key={c.id} value={c.id}>
                                            {c.name}
                                        </option>
                                    ))}
                                </NativeSelect.Field>
                            </NativeSelect.Root>
                        </Box>

                        {errors && (
                            <Text color="red.500" fontSize="sm">
                                Please fill in all fields.
                            </Text>
                        )}
                        {authError && (
                            <Text color="red.500" fontSize="sm">
                                Authentication failed. Please check your information.
                            </Text>
                        )}


                        <Stack direction="row" gap={4} mt={4}>
                            <Button flex={1} variant="outline" onClick={handleClear} colorPalette="red">
                                Clear
                            </Button>
                            <Button flex={1} onClick={handleStartExam} colorPalette="blue">
                                Start Exam
                            </Button>
                        </Stack>
                    </VStack>

                    <ExamRulesDialog
                        open={isDialogOpen}
                        onOpenChange={(e) => setIsDialogOpen(e.open)}
                        onConfirm={handleConfirmStart}
                        durationMinutes={30}
                    />
                </Box>
            </motion.div>
        </Box>
    )
}
