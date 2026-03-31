#!/bin/bash
exec jq -r '
  (.context_window.used_percentage // 0 | floor) as $pct |
  ([range(10)] | map(if . < ($pct / 10 | floor) then "█" else "░" end) | join("")) as $bar |
  (if $pct >= 80 then " !" else "" end) as $warn |
  (.cost.total_cost_usd // 0 | . * 100 | floor / 100) as $cost |
  "\(.model.display_name // "Claude") \($bar) \($pct)%\($warn) $\($cost)"
'
