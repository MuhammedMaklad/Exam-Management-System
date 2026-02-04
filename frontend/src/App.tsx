import { Box } from '@chakra-ui/react'
import { AppRouter } from './routes/AppRouter'

function App() {
  return <>
    <Box minH="100vh">
      <AppRouter />
    </Box>
  </>
}

export default App
