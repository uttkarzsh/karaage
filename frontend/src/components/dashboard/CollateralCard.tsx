import { Card } from "../ui/card";

export function CollateralCard() {
  return (
    <Card className="mb-2 border-karaageBrown">
      <h3 className="text-md font-bold text-karaageBrown mb-1">Collateral</h3>
      <div className="text-lg font-medium mb-1">$0</div>
      <div className="text-sm text-karaageBrown/70">Locked on Ethereum</div>
    </Card>
  );
}
