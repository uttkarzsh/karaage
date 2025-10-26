import { create } from "zustand";

interface State {
  currentPage: string;
  setPage: (page: string) => void;
}

export const useGlobalState = create<State>((set) => ({
  currentPage: "dashboard",
  setPage: (page) => set({ currentPage: page })
}));