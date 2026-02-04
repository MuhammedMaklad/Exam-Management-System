import { Box, Text, VStack } from '@chakra-ui/react'
import { RadioGroup, Radio } from './ui/radio'
import { type Question } from '../features/exam/examSlice'

interface QuestionCardProps {
    question: Question
    index: number
    selectedAnswer: string
    onAnswerSelect: (value: string) => void
    disabled?: boolean
}

export const QuestionCard = ({
    question,
    index,
    selectedAnswer,
    onAnswerSelect,
    disabled = false,
}: QuestionCardProps) => {
    return (
        <Box p={5} borderWidth={1} borderRadius="lg" boxShadow="sm" opacity={disabled ? 0.7 : 1}>
            <Text fontWeight="bold" mb={4}>
                {index + 1}. {question.text}
            </Text>
            <RadioGroup
                value={selectedAnswer}
                onValueChange={(details) => onAnswerSelect(details.value || '')}
                disabled={disabled}
            >
                <VStack align="start" gap={2}>
                    {question.options.map((option) => (
                        <Radio key={option} value={option} disabled={disabled}>
                            {option}
                        </Radio>
                    ))}
                </VStack>
            </RadioGroup>
        </Box>
    )
}
