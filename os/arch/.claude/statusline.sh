#!/bin/bash
exec jq -r '
  def bar(pct; len): [range(len)] | map(if . < (pct / (100/len) | floor) then "█" else "░" end) | join("");
  (.context_window.used_percentage // 0 | floor) as $pct |
  (.rate_limits.five_hour.used_percentage // null) as $r5h |
  (.rate_limits.seven_day.used_percentage // null) as $r7d |
  (if $pct >= 80 or ($r5h != null and $r5h >= 80) then " !" else "" end) as $warn |
  (if $r5h != null then "  │  5h \(bar($r5h; 5)) \($r5h | floor)%  ·  7d \($r7d // 0 | floor)%" else "" end) as $rates |
  "\(.model.display_name // "Claude")  \(bar($pct; 10)) \($pct)%\($rates)\($warn)"
'
