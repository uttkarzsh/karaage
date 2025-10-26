import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";

export default function Collateral() {
  return (
    <Card className="border-karaageBrown">
      <h2 className="text-xl font-serif font-bold text-karaageBrown mb-4 tracking-wide">
        Deposit Collateral
      </h2>
      <input
        className="w-full p-2 rounded bg-[#FEE6AE] border border-karaageBrown/40 placeholder:text-karaageBrown mb-4 text-karaageBrown focus:outline-none focus:ring-2 focus:ring-karaageBrown"
        type="number"
        placeholder="Enter amount"
      />
      <Button className="w-full bg-karaageBrown hover:bg-karaageAccent text-white font-semibold rounded-lg">
        Deposit
      </Button>
    </Card>
  );
}
