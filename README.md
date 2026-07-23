# Ogx Studio ERP

Custom Frappe app that brands ERPNext as **Ogx Studio**, plus deploy helpers for [frappe_docker](https://github.com/frappe/frappe_docker) on Vultr.

- **Site:** `erp.ogxstudio.in`
- **Stack:** Frappe / ERPNext **version-15**, MariaDB, Redis, Traefik + Let’s Encrypt
- **App name:** `ogx_studio`

## Repository layout

```
ogx_studio/          # Frappe app (hooks, logo assets, install branding)
apps.json            # Apps baked into the custom Docker image
deploy/              # Server bootstrap, image build, compose, site scripts
```

## Branding

On install/migrate the app sets:

- App title: Ogx Studio
- Desk / website logo, splash, favicon under `/assets/ogx_studio/images/`
- Website Settings + Navbar Settings

## Deploy on Vultr (summary)

1. Create an Ubuntu 24.04 VPS (≥ 4 GB RAM). Open ports 22, 80, 443.
2. Point DNS **A** record `erp.ogxstudio.in` → VPS public IP.
3. SSH in and bootstrap Docker:

```bash
git clone https://github.com/morningstar620/ogx-erp.git /opt/ogx-erp
sudo bash /opt/ogx-erp/deploy/bootstrap-server.sh
```

4. Clone frappe_docker and build the custom image:

```bash
git clone https://github.com/frappe/frappe_docker.git /opt/frappe_docker
bash /opt/ogx-erp/deploy/build-image.sh /opt/frappe_docker
```

5. Configure environment:

```bash
cd /opt/frappe_docker
cp /opt/ogx-erp/deploy/env.example .env
# Edit .env — set DB_PASSWORD, ADMIN_PASSWORD, LETSENCRYPT_EMAIL
bash /opt/ogx-erp/deploy/generate-compose.sh .env
```

6. Start the stack, wait until healthy, then create the site:

```bash
docker compose -p ogx -f compose.ogx.yaml up -d
# wait for MariaDB / backend
export $(grep -v '^#' .env | xargs)
bash /opt/ogx-erp/deploy/create-site.sh
```

7. Open `https://erp.ogxstudio.in` and sign in as **Administrator**.

## Local development note

This repo is the custom app only. For local bench:

```bash
bench get-app https://github.com/morningstar620/ogx-erp.git
bench --site <site> install-app ogx_studio
```

## License

MIT
