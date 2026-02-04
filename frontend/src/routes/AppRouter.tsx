import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { SetupPage } from '../pages/SetupPage'
import { ExamPage } from '../pages/ExamPage'
import { ResultPage } from '../pages/ResultPage'
import { GenerateExamPage } from '../pages/GenerateExamPage'

export const AppRouter = () => {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Navigate to="/setup" replace />} />
                <Route path="/setup" element={<SetupPage />} />
                <Route path="/exam" element={<ExamPage />} />
                <Route path="/result" element={<ResultPage />} />
                <Route path="/generate-exam" element={<GenerateExamPage />} />
            </Routes>
        </BrowserRouter>
    )
}
