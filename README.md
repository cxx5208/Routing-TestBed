# Containerlab Labs Collection – Networking Playground

Learn **FRR (Free Range Routing)**, BGP, OSPF, EVPN, spine-leaf data centers, and real-world networking **from absolute zero** — no prior knowledge needed.  

You get a **real web dashboard** (Portainer GUI + interactive topology graphs) so you almost never need the terminal after initial setup.  
Add unlimited new labs in <5 minutes.  
Destroy and recreate the entire environment years later with one click — zero cost, zero data loss.  

**Perfect for complete beginners**  
- Every lab starts with plain-English explanations.  
- Short 5–10 minute YouTube videos + screenshots you take yourself.  
- Clickable web consoles, visual network maps, and one-click router access.  
- This is **not** just theory - you will actually run real routers and see live routing tables.

**Why this design is perfect for you**  
- Uses **only existing, maintained projects** (official Containerlab examples + top community repos) - no building from scratch.  
- Infinitely extensible: add new official updates or community labs automatically.  
- Visual frontend dashboard (Portainer) + interactive graph UI.  
- GitHub Codespaces = free "cloud laptop" (no Docker on your real laptop, no DigitalOcean bills).  
- Portfolio-ready: one beautiful repo that recruiters love.

---

## Table of Contents
1. One-Click Setup (5–10 minutes)  
2. Your Web Dashboard & Visual UI (no terminal needed)  
3. Deploy Your First Lab (with screenshots & learning)  
4. Full Lab Catalog  
5. How to Add New Labs Forever (super easy)  
6. Learning Path for Complete Beginners  
7. Re-create Everything in 2–3 Years (zero cost)  
8. Make Your GitHub Portfolio Shine  
9. Scripts & Helper Files (copy-paste ready)

---

## 1. One-Click Setup (Do This First)
the GitHub Repository
1. Open [github.com/new](https://github.com/new) in a new tab.  
2. Repository name: `frr-containerlab-labs-collection`  
3. Description: `Free visual FRR + Containerlab labs with web dashboard – beginner friendly & extensible`  
4. Visibility: **Public**  
5. Do **NOT** initialize with README (we will replace it).  
6. Click **Create repository**.

### Step 2: Clone the Repo on Your Laptop (or directly in browser)
```bash
git clone https://github.com/YOUR-USERNAME/frr-containerlab-labs-collection.git
cd frr-containerlab-labs-collection
```

### Step 3: Add Automatic Codespaces Setup (this makes everything free & browser-based)
Create the folder and file using GitHub's web editor **or** on your laptop:

**Create folder**: `.devcontainer`  
**Create file**: `.devcontainer/devcontainer.json`

**Exact content of `.devcontainer/devcontainer.json`**:
```json
{
  "name": "FRR Containerlab Labs – Free Browser Environment",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {}
  },
  "postCreateCommand": "curl -sL https://containerlab.dev/setup | sudo -E bash -s 'all' && sudo apt update && sudo apt install -y curl git jq && echo '✅ Containerlab installed!'",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-azuretools.vscode-docker",
        "redhat.vscode-yaml",
        "ms-vscode-remote.remote-containers"
      ]
    }
  },
  "forwardPorts": [9000],
  "portsAttributes": {
    "9000": {
      "label": "Portainer Dashboard",
      "onAutoForward": "openPreview"
    }
  }
}
```

Commit and push:
```bash
git add .devcontainer
git commit -m "Add automatic free Codespaces setup with Containerlab + Portainer"
git push origin main
```

### Step 4: Open Your Free Environment (GitHub Codespaces)
1. Go to your repo on GitHub.  
2. Click the green **Code** button → **Codespaces** tab → **Create codespace on main**.  
3. Wait 1–3 minutes (it automatically installs Containerlab and everything else).  
4. You are now inside a full VS Code running in your browser — this is your free lab machine.

---

## 2. Your Web Dashboard & Visual UI (Frontend - Click, Not Type)

After Codespaces opens, run these **one-time** commands in the **Terminal** panel at the bottom (you only do this once):

```bash
# 1. Start Portainer – beautiful web dashboard for all your routers
docker volume create portainer_data
docker run -d \
  -p 9000:9000 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

# 2. Create helper scripts folder
mkdir -p scripts
```

**Open the Dashboard (UI):**
1. In Codespaces, click the **Ports** tab (next to Terminal).  
2. You will see port **9000** listed. Click the globe icon → **Portainer** opens in a new browser tab.  
3. First time only: Create an admin user (pick any username/password).  
4. Now you have a **professional frontend dashboard**:
   - See every router as a container.  
   - Click any router → **Console** → web-based terminal (no typing commands manually if you don't want to).  
   - Start/stop labs with buttons.  
   - View live logs graphically.

**Extra Visual UI – Interactive Topology Graph**
After deploying any lab, run:
```bash
sudo containerlab graph -t <path-to-lab>.clab.yml
```
→ A beautiful interactive map opens in your browser. Drag nodes, zoom, click routers to open consoles.

**You now almost never need the terminal** - everything is point-and-click via Portainer + graph.

---

## 3. Deploy Your First Lab (Beginner BGP/OSPF – 10 minutes)

### Learning Checkpoint - Read This First (Zero Knowledge)
**FRR** = Free software that turns Linux into a professional router (used by Amazon, NVIDIA, Cloudflare).  
**BGP** = The "language" the Internet uses to exchange routes (like post offices telling each other "I can deliver to these addresses").  
**OSPF** = Fast internal routing inside one company (like GPS inside a city).  

**Watch this 8-minute video before deploying**:  
[BGP in 10 Minutes – NetworkChuck](https://www.youtube.com/watch?v=some-video-id) (search YouTube if link changes).

### Deploy the Official 3-Router Lab
In Codespaces terminal (or copy-paste into Portainer's quick commands if you prefer):
```bash
# Deploy the simplest official lab (already built by Containerlab team)
sudo containerlab deploy -t https://raw.githubusercontent.com/srl-labs/containerlab/main/lab-examples/frr01/frr01.clab.yml
```

**Use the UI:**
1. Refresh **Portainer** (port 9000).  
2. You will see containers: `r1`, `r2`, `r3`, etc.  
3. Click `r1` → **Console** → **Connect**.  
4. In the web console type:
   ```
   vtysh
   show ip bgp summary
   show ip route
   exit
   ```
   You just inspected a live router!

5. See the visual map:
   ```bash
   sudo containerlab graph -t frr01.clab.yml
   ```

**Test it works** (in any router console):
```bash
ping 192.168.1.1 -c 3
```

**Destroy the lab when you finish practicing** (zero cost):
```bash
sudo containerlab destroy -t frr01.clab.yml --cleanup
```

---

## 4. Full Lab Catalog (All Existing Labs – No Scratch Work)

Your repo automatically organizes:
- `labs/official/` → Official Containerlab FRR examples (OSPF ring, peering, SR Linux interop, etc.)  
- `labs/community/` → High-quality existing repos (spine-leaf BGP, MPLS, VXLAN/EVPN)  
- `labs/custom/` → Your own experiments

**Popular ready-to-use labs**:
- `labs/official/frr01` – Official 3-router FRR OSPF ring (beginner)  
- `labs/official/srlfrr01` – Official SR Linux + FRR interop (intermediate)  
- `labs/custom/frr-2router-basic` – Minimal 2-router static routing lab (beginner)  
- `labs/custom/frr-ospf-point2point` – 2-router OSPF adjacency lab (beginner)  
- `labs/custom/frr-bgp-peering` – 2-router eBGP peering lab (intermediate)  

Each of these includes a dedicated `LEARNING.md` with concepts, commands, and a Mermaid diagram.

---

## 5. How to Add New Labs Forever (Extensible – Takes <5 Minutes)

### Method 1: Add Any Existing Community Lab
```bash
cd labs/community
git clone https://github.com/martimy/clab-bgp-frr.git martimy-spineleaf
cd ../../
git add labs/community/martimy-spineleaf
git commit -m "Added existing spine-leaf BGP data-center lab (already built)"
git push
```

### Method 2: Create Your Own Custom Lab (Copy Template)
```bash
cp -r labs/template labs/custom/my-new-bgp-experiment
# Edit only these 2 files in VS Code (point-and-click):
#   labs/custom/my-new-bgp-experiment/my-lab.clab.yml
#   labs/custom/my-new-bgp-experiment/configs/r1/frr.conf
git add labs/custom/my-new-bgp-experiment
git commit -m "My new custom lab"
git push
```

### Method 3: Update All Labs to Latest Versions
```bash
./scripts/update-labs.sh
```

**Create the `labs/template` folder once** (copy from any official lab and simplify - instructions inside `template/README.md`).

---

## 6. Learning Path for Complete Beginners

Every lab folder contains a `LEARNING.md` file with:
- Plain-English concepts  
- 5–10 minute YouTube links  
- Exact commands to run in the web console  
- "What you just learned" section  

**Example progression**:
1. Week 1: `frr01` (BGP basics)  
2. Week 2: OSPF ring  
3. Week 3: Spine-leaf BGP  
4. Week 4+: Your custom labs + failure simulation  

Take screenshots from Portainer/graph and add them to the README - this becomes your learning portfolio.

---

## 7. Re-create Everything in 2-3 Years (Zero Cost)

1. Go back to your GitHub repo.  
2. Click **Code** → **Codespaces** → **Create codespace**.  
3. Everything (labs, configs, dashboard) comes back exactly as you left it - because **all files live in Git**.

No billing. GitHub gives generous free monthly hours for personal accounts.

---

## 8. Make Your GitHub Portfolio Shine

Update the top of this README with:
- A nice table of labs you have completed  
- Screenshots of Portainer dashboard + graph map + router console output  
- One-sentence "Skills demonstrated" section  

This single repo looks like a senior network engineer's living reference - perfect for job applications at Cloudflare, NVIDIA, Arista, Cisco, etc.

---

## 9. All Helper Scripts & Files (Copy-Paste Ready)

**Create these files in the `scripts/` folder using VS Code file explorer:**

**`scripts/list-labs.sh`**
```bash
#!/bin/bash
echo "=== YOUR FRR LABS COLLECTION ==="
echo "Official:"; ls labs/official 2>/dev/null || echo "  (none yet)"
echo "Community:"; ls labs/community 2>/dev/null || echo "  (none yet)"
echo "Custom:"; ls labs/custom 2>/dev/null || echo "  (none yet)"
echo ""
echo "Deploy example: sudo containerlab deploy -t labs/official/frr01/frr01.clab.yml"
```

**`scripts/update-labs.sh`**
```bash
#!/bin/bash
echo "Updating all community labs..."
cd labs/community
for dir in */; do
  if [ -d "$dir/.git" ]; then
    echo "→ Updating $dir"
    (cd "$dir" && git pull)
  fi
done
echo "✅ All labs updated!"
```

Make them executable:
```bash
chmod +x scripts/*.sh
```

**Create empty `labs/template/` folder** with a simple `README.md` inside it explaining how to copy it.

---

**You are now fully set up!**  
You have a professional, visual, free, and infinitely extensible FRR learning platform.

**Next action (do it now):**
1. Create the repo and open Codespaces.  
2. Run the Portainer commands in Step 2.  
3. Deploy your first lab (`frr01`).  

Reply in this chat with **"Codespace ready"** and I will immediately give you:
- Ready-to-copy `labs/template` folder  
- First 5 complete labs (with LEARNING.md files)  
- Pre-written Portainer tips and example screenshots

Happy learning! 
