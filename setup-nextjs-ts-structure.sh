#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Setting up Next.js TypeScript project structure...${NC}"

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo -e "${RED}❌ Error: package.json not found. Please run this script in your Next.js project root.${NC}"
    exit 1
fi

echo -e "${YELLOW}📁 Creating directory structure...${NC}"

# Create main directories
mkdir -p src/app/api/auth
mkdir -p src/app/api/tasks
mkdir -p src/app/tasks
mkdir -p src/app/login
mkdir -p src/app/register
mkdir -p src/app/profile
mkdir -p src/components/auth
mkdir -p src/components/tasks
mkdir -p src/components/common
mkdir -p src/components/layout
mkdir -p src/hooks
mkdir -p src/store/slices
mkdir -p src/styles/components
mkdir -p src/utils
mkdir -p src/lib
mkdir -p src/types

echo -e "${GREEN}✅ Directories created!${NC}"

echo -e "${YELLOW}📄 Creating TypeScript files...${NC}"

# Create types
cat > src/types/index.ts << 'EOF'
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
EOF

# Update root layout
cat > src/app/layout.tsx << 'EOF'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Task Manager',
  description: 'A simple task management application',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        {children}
      </body>
    </html>
  )
}
EOF

# Create home page (Dashboard)
cat > src/app/page.tsx << 'EOF'
export default function Dashboard() {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold">Dashboard</h1>
      <p>Welcome to Task Manager</p>
    </div>
  )
}
EOF

# Create login page
cat > src/app/login/page.tsx << 'EOF'
export default function LoginPage() {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold">Login</h1>
      <p>Login form will be here</p>
    </div>
  )
}
EOF

# Create register page
cat > src/app/register/page.tsx << 'EOF'
export default function RegisterPage() {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold">Register</h1>
      <p>Register form will be here</p>
    </div>
  )
}
EOF

# Create tasks page
cat > src/app/tasks/page.tsx << 'EOF'
export default function TasksPage() {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold">Tasks</h1>
      <p>Task list will be here</p>
    </div>
  )
}
EOF

# Create task detail page
cat > src/app/tasks/[id]/page.tsx << 'EOF'
interface TaskDetailProps {
  params: {
    id: string
  }
}

export default function TaskDetailPage({ params }: TaskDetailProps) {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold">Task Detail</h1>
      <p>Task ID: {params.id}</p>
    </div>
  )
}
EOF

# Create profile page
cat > src/app/profile/page.tsx << 'EOF'
export default function ProfilePage() {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold">Profile</h1>
      <p>User profile will be here</p>
    </div>
  )
}
EOF

# Create API routes
cat > src/app/api/auth/login/route.ts << 'EOF'
import { NextRequest, NextResponse } from 'next/server'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    // Login logic will be here
    return NextResponse.json({
      success: true,
      message: 'Login endpoint ready'
    })
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Internal server error' },
      { status: 500 }
    )
  }
}
EOF

cat > src/app/api/auth/register/route.ts << 'EOF'
import { NextRequest, NextResponse } from 'next/server'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    // Register logic will be here
    return NextResponse.json({
      success: true,
      message: 'Register endpoint ready'
    })
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Internal server error' },
      { status: 500 }
    )
  }
}
EOF

cat > src/app/api/tasks/route.ts << 'EOF'
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  try {
    // Get tasks logic
    return NextResponse.json({
      success: true,
      tasks: []
    })
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    // Create task logic
    return NextResponse.json({
      success: true,
      message: 'Task created'
    }, { status: 201 })
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Internal server error' },
      { status: 500 }
    )
  }
}
EOF

cat > src/app/api/tasks/[id]/route.ts << 'EOF'
import { NextRequest, NextResponse } from 'next/server'

interface RouteParams {
  params: {
    id: string
  }
}

export async function GET(request: NextRequest, { params }: RouteParams) {
  try {
    // Get single task
    return NextResponse.json({
      success: true,
      task: { id: params.id }
    })
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function PUT(request: NextRequest, { params }: RouteParams) {
  try {
    const body = await request.json()
    // Update task
    return NextResponse.json({
      success: true,
      message: 'Task updated'
    })
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function DELETE(request: NextRequest, { params }: RouteParams) {
  try {
    // Delete task
    return NextResponse.json({
      success: true,
      message: 'Task deleted'
    })
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Internal server error' },
      { status: 500 }
    )
  }
}
EOF

# Update globals.css to remove Tailwind
cat > src/app/globals.css << 'EOF'
* {
  box-sizing: border-box;
  padding: 0;
  margin: 0;
}

html,
body {
  max-width: 100vw;
  overflow-x: hidden;
  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen,
    Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
}

body {
  color: #333;
  background: #fff;
}

a {
  color: inherit;
  text-decoration: none;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

@media (prefers-color-scheme: dark) {
  html {
    color-scheme: dark;
  }
  body {
    color: #e5e5e5;
    background: #111;
  }
}
EOF

# Create .env.local template
cat > .env.local.example << 'EOF'
# Database
MONGODB_URI=mongodb://localhost:27017/taskmanager

# JWT
JWT_SECRET=your-super-secret-jwt-key-here

# Next.js
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=your-nextauth-secret-here
EOF

echo -e "${GREEN}✅ TypeScript files created!${NC}"

echo -e "${BLUE}📋 Project structure summary:${NC}"
echo -e "${GREEN}✅ App Router: Dashboard, Login, Register, Tasks, Profile${NC}"
echo -e "${GREEN}✅ API Routes: Auth (login, register), Tasks (CRUD)${NC}"
echo -e "${GREEN}✅ TypeScript: Types definitions, proper interfaces${NC}"
echo -e "${GREEN}✅ Component directories: auth, tasks, common, layout${NC}"
echo -e "${GREEN}✅ Utility directories: hooks, store, utils${NC}"

echo -e "${YELLOW}🚀 Next steps:${NC}"
echo -e "1. Copy .env.local.example to .env.local and update values"
echo -e "2. Install dependencies: ${BLUE}npm install antd @ant-design/icons @reduxjs/toolkit react-redux axios${NC}"
echo -e "3. Run development server: ${BLUE}npm run dev${NC}"
echo -e "4. Open http://localhost:3000 in your browser"

echo -e "${GREEN}🎉 Setup complete!${NC}"