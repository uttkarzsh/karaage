import { useGlobalState } from "../../store/globalState";
import { Home, Shield, DollarSign } from "lucide-react";

export function Sidebar() {
  const { setPage } = useGlobalState();

  return (
    <aside className="flex flex-col px-4 pt-2 w-56 bg-transparent">
      <h2 className="text-2xl font-serif font-bold mb-8 text-karaageBrown text-center tracking-wide">
        KARAAGE
      </h2>
      <nav className="flex flex-col gap-2">
        <button
          onClick={() => setPage("dashboard")}
          className="flex gap-3 items-center px-3 py-2 rounded-lg font-medium text-karaageBrown hover:bg-karaageAccent/20 hover:text-karaageAccent transition"
        >
          <Home className="stroke-[2] text-karaageBrown" /> Dashboard
        </button>
        <button
          onClick={() => setPage("collateral")}
          className="flex gap-3 items-center px-3 py-2 rounded-lg font-medium text-karaageBrown hover:bg-karaageAccent/20 hover:text-karaageAccent transition"
        >
          <Shield className="stroke-[2] text-karaageBrown" /> Collateral
        </button>
        <button
          onClick={() => setPage("borrow")}
          className="flex gap-3 items-center px-3 py-2 rounded-lg font-medium text-karaageBrown hover:bg-karaageAccent/20 hover:text-karaageAccent transition"
        >
          <DollarSign className="stroke-[2] text-karaageBrown" /> Borrow
        </button>
      </nav>
    </aside>
  );
}
