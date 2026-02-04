import { configureStore } from '@reduxjs/toolkit'
import { useDispatch, useSelector } from 'react-redux'
import studentReducer from '../features/student/studentSlice'
import examReducer from '../features/exam/examSlice'

export const store = configureStore({
    reducer: {
        student: studentReducer,
        exam: examReducer,
    },
})

export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = typeof store.dispatch

export const useAppDispatch = useDispatch.withTypes<AppDispatch>()
export const useAppSelector = useSelector.withTypes<RootState>()
