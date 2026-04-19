#!/bin/bash
echo "=== YOUR FRR LABS COLLECTION ==="
echo "Official:"; ls labs/official 2>/dev/null || echo "  (none yet)"
echo "Community:"; ls labs/community 2>/dev/null || echo "  (none yet)"
echo "Custom:"; ls labs/custom 2>/dev/null || echo "  (none yet)"
echo ""
echo "Deploy example: sudo containerlab deploy -t labs/official/frr01/frr01.clab.yml"