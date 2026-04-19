# Lab Template

Use this folder as a template to create your own custom FRR labs.

## How to use

1. Copy this entire folder to `labs/custom/your-lab-name`:
   ```bash
   cp -r labs/template labs/custom/your-lab-name
   ```

2. Edit the following files:
   - `your-lab.clab.yml` - Containerlab topology definition
   - `configs/r1/frr.conf` - FRR configuration (add more router configs as needed)

3. Deploy your lab:
   ```bash
   sudo containerlab deploy -t labs/custom/your-lab-name/your-lab.clab.yml
   ```

4. When done, destroy:
   ```bash
   sudo containerlab destroy -t labs/custom/your-lab-name/your-lab.clab.yml --cleanup
   ```

## Files in this template

- `template.clab.yml` - Example topology file (rename to your lab name)
- `configs/` - Folder for FRR router configurations
- `LEARNING.md` - Create your own learning notes here

## Tips

- Use existing labs in `labs/official/` as reference
- Test your topology with `containerlab graph -t your-lab.clab.yml`
- Check FRR configs with `vtysh` in the router console