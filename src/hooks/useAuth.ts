import { useEffect } from 'react'
import { useAppDispatch, useAppSelector } from './redux'
import { loginSuccess, logout, updateUser, setLoading, initializeAuth } from '@/store/slices/authSlice'

const useAuth = () => {
    const dispatch = useAppDispatch()
    const { user, isAuthenticated, token, loading } = useAppSelector((state) => state.auth)

    useEffect(() => {
        // Initialize auth state from localStorage
        dispatch(initializeAuth())
    }, [dispatch])

    const handleLogin = async (email: string, password: string) => {
        try {
            dispatch(setLoading(true))
            // API call logic will be here later
            const mockResponse = {
                success: true,
                user: { _id: '1', id: '1', name: 'Test User', email, createdAt: '', updatedAt: '' },
                accessToken: 'mock-token'
            }

            dispatch(loginSuccess({
                user: mockResponse.user,
                token: mockResponse.accessToken
            }))
        } catch (error) {
            dispatch(setLoading(false))
            throw error
        }
    }

    const handleLogout = () => {
        dispatch(logout())
    }

    const handleUpdateUser = (userData: any) => {
        dispatch(updateUser(userData))
    }

    return {
        user,
        isAuthenticated,
        token,
        loading,
        login: handleLogin,
        logout: handleLogout,
        updateUser: handleUpdateUser
    }
}

export default useAuth