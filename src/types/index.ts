// User types
export interface User {
  _id: string;
  id: string;
  name: string;
  email: string;
  createdAt: string;
  updatedAt: string;
}

// Task types
export interface Task {
  _id: string;
  id: string;
  title: string;
  description?: string;
  status: 'pending' | 'in-progress' | 'completed';
  priority: 'low' | 'medium' | 'high';
  user: string;
  createdAt: string;
  updatedAt: string;
}

// Auth types
export interface AuthState {
  isAuthenticated: boolean;
  user: User | null;
  token: string | null;
  loading: boolean;
}

// API Response types
export interface ApiResponse<T = any> {
  success: boolean;
  message?: string;
  data?: T;
  tasks?: T[];
  task?: T;
  user?: T;
  accessToken?: string;
}
