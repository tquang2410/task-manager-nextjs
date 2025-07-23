import { useAppDispatch, useAppSelector } from './redux'
import useAuth from './useAuth'
import { useEffect } from 'react'
import {
    setLoading,
    setTasks,
    addTask,
    updateTask,
    deleteTask,
    setFilter,
    openModal,
    closeModal,
} from '@/store/slices/taskSlice'

const useTask = () => {
    const dispatch = useAppDispatch()
    const { user, isAuthenticated } = useAuth()
    const { tasks, loading, filter, isModalOpen, editingTask } = useAppSelector(
        (state) => state.tasks
    )

    // Mock data for testing
    useEffect(() => {
        if (isAuthenticated && user) {
            console.log('🔄 Loading tasks for user:', user.email)
            // Mock tasks
            const mockTasks = [
                {
                    _id: '1',
                    id: '1',
                    title: 'Test Task 1',
                    description: 'This is a test task',
                    status: 'pending' as const,
                    priority: 'medium' as const,
                    user: user.id,
                    createdAt: new Date().toISOString(),
                    updatedAt: new Date().toISOString(),
                }
            ]
            dispatch(setTasks(mockTasks))
        }
    }, [isAuthenticated, user, dispatch])

    const filteredTasks = tasks.filter(task => {
        if (filter === 'all') return true
        return task.status === filter
    })

    return {
        tasks,
        filteredTasks,
        loading,
        filter,
        isModalOpen,
        editingTask,
        setFilter: (newFilter: typeof filter) => dispatch(setFilter(newFilter)),
        openModal: (task = null) => dispatch(openModal(task)),
        closeModal: () => dispatch(closeModal()),
    }
}

export default useTask