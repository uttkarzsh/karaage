import { cn } from "../../lib/utils";

export function Button({ children, className, ...props }: any) {
  return (
    <button
      className={cn(
        "px-4 py-2 bg-primary text-white rounded-md hover:bg-indigo-500 transition",
        className
      )}
      {...props}
    >
      {children}
    </button>
  );
}