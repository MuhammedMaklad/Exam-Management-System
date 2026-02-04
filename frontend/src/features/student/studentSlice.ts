import { createSlice, type PayloadAction } from '@reduxjs/toolkit'

export interface StudentState {
    firstName: string
    lastName: string
    trackId: number | null
    trackName: string
    courseId: number | null
    courseName: string
}

const initialState: StudentState = {
    firstName: '',
    lastName: '',
    trackId: null,
    trackName: '',
    courseId: null,
    courseName: '',
}

export const studentSlice = createSlice({
    name: 'student',
    initialState,
    reducers: {
        setStudentInfo: (state, action: PayloadAction<StudentState>) => {
            state.firstName = action.payload.firstName
            state.lastName = action.payload.lastName
            state.trackId = action.payload.trackId
            state.trackName = action.payload.trackName
            state.courseId = action.payload.courseId
            state.courseName = action.payload.courseName
        },
        clearStudentInfo: (state) => {
            state.firstName = ''
            state.lastName = ''
            state.trackId = null
            state.trackName = ''
            state.courseId = null
            state.courseName = ''
        },
    },
})

export const { setStudentInfo, clearStudentInfo } = studentSlice.actions
export default studentSlice.reducer
