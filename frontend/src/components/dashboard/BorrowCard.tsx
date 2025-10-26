import { Card } from "../ui/card";
import { Button } from "../ui/button";

export function BorrowCard() {
  return (
    <Card>
      <h3 className="text-md font-bold text-karaageAccent mb-1">Borrowed on Hedera</h3>
      <div className="text-lg font-medium mb-2">0 HBAR</div>
      <Button className="bg-karaageAccent text-white w-full rounded-lg">
        Repay
      </Button>
    </Card>
  );
}
