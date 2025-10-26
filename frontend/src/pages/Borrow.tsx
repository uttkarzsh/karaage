import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";

export default function Borrow() {
  return (
    <Card className="border-karaageAccent">
      <h2 className="text-xl font-serif font-bold text-karaageAccent mb-4 tracking-wide">
        Borrow on Hedera
      </h2>
      <input
        className="w-full p-2 rounded bg-[#FEE6AE] border border-karaageAccent/40 placeholder:text-karaageBrown mb-4 text-karaageBrown focus:outline-none focus:ring-2 focus:ring-karaageAccent"
        type="number"
        placeholder="Enter HBAR amount"
      />
      <Button className="w-full bg-karaageAccent hover:bg-[#F0983E] text-white font-semibold rounded-lg">
        Borrow
      </Button>
    </Card>
  );
}
