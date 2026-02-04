import { Box, Flex, Button, Heading, Spacer } from '@chakra-ui/react'
import { useNavigate } from 'react-router-dom'

export const Navbar = () => {
    const navigate = useNavigate()

    return (
        <Box px={10} py={4} boxShadow="sm" borderBottomWidth="1px" bg="white">
            <Flex align="center">
                <Heading size="md" color="blue.600" cursor="pointer" onClick={() => navigate('/setup')}>
                    Exam Portal
                </Heading>
                <Spacer />
                <Button colorPalette="blue" variant="ghost" onClick={() => navigate('/generate-exam')}>
                    Generate Exam
                </Button>
            </Flex>
        </Box>
    )
}
