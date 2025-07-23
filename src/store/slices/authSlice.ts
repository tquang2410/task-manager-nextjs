import { createSlice, PayloadAction} from "@reduxjs/toolkit";
import { AuthState, User} from "@/types";
const initialState: AuthState = {
    isAuthenticated: false,
    user: null,
    token: null,
    loading: true,
}
const authSlice = createSlice({
    name: "auth",
    initialState,
    reducers : {
        loginSuccess: (state, action: PayloadAction<{user: User; token: string}>) => {
            const { user, token } = action.payload;
            // Save to localStorage
            if ( typeof window !== "undefined") {
                localStorage.setItem("userData", JSON.stringify(user));
                localStorage.setItem("accessToken", token);
            }
            state.isAuthenticated = true;
            state.user = user;
            state.token = token;
            state.loading = false;
        },
        logout: (state) => {
            // Clear localStorage
            if (typeof window !== "undefined") {
                localStorage.removeItem("userData");
                localStorage.removeItem("accessToken");
            }
            state.isAuthenticated = false;
            state.user = null;
            state.token = null;
            state.loading = false;
        },
        setLoading: (state, action: PayloadAction<boolean>) => {
            state.loading = action.payload;
        },
        initializeAuth: (state) => {
            if (typeof window !== "undefined") {
                const token = localStorage.getItem("accessToken");
                const userData = localStorage.getItem('userData');
                if ( token && userData ){
                    state.token = token
                    state.user = JSON.parse(userData);
                    state.isAuthenticated = true;
                }
            }
            state.loading = false;
        },
        updateUser: (state, action: PayloadAction<Partial<User>>) => {
            if ( state.user){
                state.user = { ...state.user, ...action.payload }
                if (typeof window !== "undefined") {
                    localStorage.setItem('userData', JSON.stringify(state.user))
                }
            }
        },
    },
})
export const { loginSuccess, logout, setLoading, initializeAuth, updateUser } = authSlice.actions;
export default authSlice.reducer;