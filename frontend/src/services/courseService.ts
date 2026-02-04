import axios from 'axios'
import { type Track, type Course } from './types'

const BASE_URL = 'http://localhost:5261/api'

export const getTracks = async (): Promise<Track[]> => {
    const response = await axios.get<Track[]>(`${BASE_URL}/tracks/getTracks`)
    return response.data
}

export const getTrackCourses = async (trackId: number): Promise<Course[]> => {
    const response = await axios.get<Course[]>(`${BASE_URL}/courses/getTrackCourses/${trackId}`)
    return response.data
}

export const getCourses = async (): Promise<Course[]> => {
    const response = await axios.get<Course[]>(`${BASE_URL}/courses/getCourses`)
    return response.data
}
