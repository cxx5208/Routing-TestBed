# frr-bgp-peering Learning Guide

## What this lab is

This custom lab creates an eBGP session between two FRR routers in different autonomous systems (AS65001 and AS65002).

```mermaid
graph LR
  R1[r1\nAS65001\n10.10.10.0/24] ---|eBGP 10.0.12.0/30| R2[r2\nAS65002\n10.20.20.0/24]
```

## Concepts in plain English

- BGP is the routing protocol used between different networks (autonomous systems).
- Neighbors exchange route advertisements when the peering session is established.

## Deploy

```bash
sudo containerlab deploy -t labs/custom/frr-bgp-peering/frr-bgp-peering.clab.yml
```

## Commands to run

```bash
docker exec -it clab-frr-bgp-peering-r1 vtysh -c "show ip bgp summary"
docker exec -it clab-frr-bgp-peering-r1 vtysh -c "show ip bgp"
docker exec -it clab-frr-bgp-peering-r2 vtysh -c "show ip bgp"
```

## What you just learned

- How to establish a minimal eBGP peering.
- How each side advertises a local network.
- How to read BGP state and learned prefixes.

## Cleanup

```bash
sudo containerlab destroy -t labs/custom/frr-bgp-peering/frr-bgp-peering.clab.yml --cleanup
```
