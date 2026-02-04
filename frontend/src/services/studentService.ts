import axios from 'axios'
import { type AuthData } from './types'

const BASE_URL = 'http://localhost:5261/api'

export const authenticateStudent = async (data: AuthData): Promise<boolean> => {
    try {
        const authData = {
            StudentFullName: `${data.firstName} ${data.lastName}`,
            TrackId: data.trackId,
            CourseId: data.courseId
        }
        const response = await axios.post(`${BASE_URL}/students/validate`, authData)
        return response.status === 200
    } catch (error) {
        console.error('Authentication failed:', error)
        return false
    }
}
