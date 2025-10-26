import { CollateralCard } from "../components/dashboard/CollateralCard";
import { BorrowCard } from "../components/dashboard/BorrowCard";

export default function Dashboard() {
  return (
    <div className="flex flex-col gap-4">
      <CollateralCard />
      <BorrowCard />
    </div>
  );
}