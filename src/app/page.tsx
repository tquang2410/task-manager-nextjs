'use client'

import useAuth from '@/hooks/useAuth'
import useTask from '@/hooks/useTask'

export default function Dashboard() {
    const { loading, isAuthenticated, user, login } = useAuth()
    const { tasks, filteredTasks } = useTask()

    const handleTestLogin = () => {
        login('test@example.com', 'password')
    }

    return (
        <div className="container mx-auto p-4">
            <h1 className="text-2xl font-bold">Dashboard</h1>
            <p>Welcome to Task Manager</p>
            <p>Auth Status: {isAuthenticated ? 'Logged In' : 'Not Logged In'}</p>
            <p>Loading: {loading ? 'Yes' : 'No'}</p>
            {user && <p>User: {user.name}</p>}
            <p>Tasks Count: {tasks.length}</p>

            {!isAuthenticated && (
                <button
                    onClick={handleTestLogin}
                    className="bg-blue-500 text-white px-4 py-2 rounded mt-4"
                >
                    Test Login
                </button>
            )}
        </div>
    )
}