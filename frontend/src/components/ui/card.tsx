import { cn } from "../../lib/utils";

export function Card({ children, className }: any) {
  return (
    <div
      className={cn(
        "w-full bg-white/80 border-2 rounded-xl p-5 shadow hover:shadow-lg transition",
        className
      )}
    >
      {children}
    </div>
  );
}
