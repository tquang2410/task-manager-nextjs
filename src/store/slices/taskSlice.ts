import { createSlice, PayloadAction } from '@reduxjs/toolkit'
import { Task } from '@/types'

interface TaskState {
    tasks: Task[]
    loading: boolean
    filter: 'all' | 'pending' | 'in-progress' | 'completed'
    isModalOpen: boolean
    editingTask: Task | null
}

const initialState: TaskState = {
    tasks: [],
    loading: false,
    filter: 'all',
    isModalOpen: false,
    editingTask: null,
}

const taskSlice = createSlice({
    name: 'tasks',
    initialState,
    reducers: {
        setLoading: (state, action: PayloadAction<boolean>) => {
            state.loading = action.payload
        },
        setTasks: (state, action: PayloadAction<Task[]>) => {
            state.tasks = action.payload
        },
        addTask: (state, action: PayloadAction<Task>) => {
            state.tasks.unshift(action.payload)
        },
        updateTask: (state, action: PayloadAction<{ id: string; data: Partial<Task> }>) => {
            const { id, data } = action.payload
            const index = state.tasks.findIndex(task => task.id === id)
            if (index !== -1) {
                state.tasks[index] = { ...state.tasks[index], ...data }
            }
        },
        deleteTask: (state, action: PayloadAction<string>) => {
            state.tasks = state.tasks.filter(task => task.id !== action.payload)
        },
        setFilter: (state, action: PayloadAction<TaskState['filter']>) => {
            state.filter = action.payload
        },
        openModal: (state, action: PayloadAction<Task | null>) => {
            state.isModalOpen = true
            state.editingTask = action.payload
        },
        closeModal: (state) => {
            state.isModalOpen = false
            state.editingTask = null
        },
    },
})

export const {
    setLoading,
    setTasks,
    addTask,
    updateTask,
    deleteTask,
    setFilter,
    openModal,
    closeModal,
} = taskSlice.actions

export default taskSlice.reducer