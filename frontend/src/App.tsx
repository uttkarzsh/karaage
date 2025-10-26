import logo from './assets/logokaraage.jpeg';
import { ConnectWalletButton } from './components/ConnectWalletButton';
import Dashboard from './pages/Dashboard';
import { Sidebar } from './components/layout/Sidebar';
import Borrow from './pages/Borrow';
import Collateral from './pages/Collateral';
import { useGlobalState } from './store/globalState';

export default function App() {
  const { currentPage } = useGlobalState();

  return (
    <div className="min-h-screen flex flex-col items-center justify-start bg-karaageBg">
      <div className="w-full flex flex-col items-center mt-10">
        <img
          src={logo}
          alt="Karaage Logo"
          className="w-36 h-36 mb-2 object-contain"
          style={{ borderRadius: 32, boxShadow: "0 2px 20px #A45B2455" }}
        />
        <h1 className="text-5xl font-serif text-karaageBrown font-bold tracking-wide">
          KARAAGE
        </h1>
        <ConnectWalletButton />
        <div className="w-full max-w-md space-y-6 mt-2">
          <Sidebar />
          <main className="flex-1 p-6 overflow-y-auto">
        {currentPage === "dashboard" && <Dashboard />}
        {currentPage === "collateral" && <Collateral />}
        {currentPage === "borrow" && <Borrow />}
      </main>
        </div>
      </div>
    </div>
  );
}
