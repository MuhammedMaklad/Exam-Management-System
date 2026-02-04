import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Text, Box } from '@chakra-ui/react'
import { useAppDispatch, useAppSelector } from '../app/store'
import { submitExam } from '../features/exam/examSlice'

export const Timer = () => {
    const durationMinutes = useAppSelector((state) => state.exam.duration)
    const [timeLeft, setTimeLeft] = useState(durationMinutes * 60)
    const dispatch = useAppDispatch()
    const navigate = useNavigate()

    useEffect(() => {
        setTimeLeft(durationMinutes * 60)
    }, [durationMinutes])

    useEffect(() => {
        if (timeLeft <= 0 && durationMinutes > 0) {
            dispatch(submitExam())
            navigate('/result')
            return
        }

        if (timeLeft <= 0) return

        const timer = setInterval(() => {
            setTimeLeft((prev) => prev - 1)
        }, 1000)

        return () => clearInterval(timer)
    }, [timeLeft, dispatch, navigate, durationMinutes])

    const formatTime = (seconds: number) => {
        const m = Math.floor(seconds / 60)
        const s = seconds % 60
        return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
    }

    // Warning color if less than 1 minute
    const isUrgent = timeLeft < 60

    return (
        <Box
            position="sticky"
            top={0}
            zIndex="sticky"
            bg="bg.panel"
            py={2}
            boxShadow="sm"
            textAlign="center"
        >
            <Text
                fontSize="xl"
                fontWeight="bold"
                color={isUrgent ? 'red.500' : 'blue.500'}
            >
                Time Left: {formatTime(timeLeft)}
            </Text>
        </Box>
    )
}
