# SSL Configuration dla Open WebUI + LiteLLM

## 🔐 Szybki Start - Self-Signed Certificate

### Linux/WSL:
```bash
cd scripts
chmod +x generate-ssl.sh
./generate-ssl.sh
```

### Windows (PowerShell):
```powershell
cd config/nginx
mkdir ssl -ErrorAction SilentlyContinue

# Generuj certyfikat
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 `
    -keyout ssl/key.pem `
    -out ssl/cert.pem `
    -subj "/C=PL/ST=Poland/L=Warsaw/O=HomeLab/OU=AI/CN=localhost"
```

## 📦 Struktura katalogów

```
config/nginx/
├── nginx.conf          # Konfiguracja Nginx
└── ssl/
    ├── cert.pem        # Certyfikat SSL (generowany)
    └── key.pem         # Klucz prywatny (generowany)

scripts/
└── generate-ssl.sh     # Skrypt do generowania certyfikatu

docs/
└── SSL_SETUP.md        # Ta dokumentacja
```

## 🌐 Dostęp do usług

Po uruchomieniu z SSL:

- **Open WebUI HTTPS**: https://localhost:8443 lub https://TWOJ_IP:8443 (SSL ✅)
- **Open WebUI HTTP**: http://localhost:8080 lub http://TWOJ_IP:8080 (przekierowanie → HTTPS)
- **LiteLLM API**: http://TWOJ_IP:4000 lub http://localhost:4000 (bez SSL)

### 🔀 Port Forwarding na routerze:

```
Zewnętrzny Port 443 → Wewnętrzny Port 8443 (Open WebUI HTTPS)
Zewnętrzny Port 80  → Wewnętrzny Port 8080 (Open WebUI HTTP)
Zewnętrzny Port 4000 → Wewnętrzny Port 4000 (LiteLLM - opcjonalnie)
```

## ⚠️ Self-Signed Certificate - Ostrzeżenia przeglądarki

Przy pierwszym połączeniu zobaczysz ostrzeżenie:

### Chrome/Edge:
1. Kliknij "Advanced" / "Zaawansowane"
2. Kliknij "Proceed to [IP] (unsafe)" / "Przejdź do [IP] (niebezpieczne)"

### Firefox:
1. Kliknij "Advanced" / "Zaawansowane"
2. Kliknij "Accept the Risk and Continue" / "Zaakceptuj ryzyko i kontynuuj"

### Trwałe dodanie certyfikatu do zaufanych:

#### Chrome/Edge (Windows):
```powershell
# Import do Windows Certificate Store
certutil -addstore "Root" config\nginx\ssl\cert.pem
```

#### Firefox:
Settings → Privacy & Security → Certificates → View Certificates → Authorities → Import → Wybierz `cert.pem`

#### Linux:
```bash
sudo cp config/nginx/ssl/cert.pem /usr/local/share/ca-certificates/openwebui.crt
sudo update-ca-certificates
```

## 🔒 Bezpieczeństwo

### Self-Signed Certificate:
✅ **Zalety:**
- Darmowy
- Natychmiastowa konfiguracja
- Szyfrowanie ruchu
- Idealny dla połączeń po IP

❌ **Wady:**
- Ostrzeżenia w przeglądarce
- Nie zweryfikowany przez CA
- Tylko dla użytku prywatnego/rozwojowego

### Konfiguracja SSL w nginx.conf:

```nginx
ssl_protocols TLSv1.2 TLSv1.3;           # Tylko bezpieczne protokoły
ssl_ciphers HIGH:!aNULL:!MD5;            # Silne szyfry
ssl_prefer_server_ciphers on;            # Preferuj szyfry serwera
add_header Strict-Transport-Security     # HSTS - wymuś HTTPS
```

## 📝 Własny certyfikat

Jeśli masz własny certyfikat (np. od CA lub Let's Encrypt):

1. Skopiuj pliki certyfikatu:
```bash
cp twoj-cert.pem config/nginx/ssl/cert.pem
cp twoj-klucz.pem config/nginx/ssl/key.pem
chmod 600 config/nginx/ssl/key.pem
chmod 644 config/nginx/ssl/cert.pem
```

2. Restart Nginx:
```bash
docker compose restart nginx
```

## 🔄 Let's Encrypt (dla domeny)

Jeśli jednak zdecydujesz się na domenę:

1. Zainstaluj certbot:
```bash
sudo apt-get install certbot python3-certbot-nginx
```

2. Wygeneruj certyfikat:
```bash
sudo certbot certonly --standalone -d twoja-domena.pl
```

3. Skopiuj certyfikaty:
```bash
sudo cp /etc/letsencrypt/live/twoja-domena.pl/fullchain.pem config/nginx/ssl/cert.pem
sudo cp /etc/letsencrypt/live/twoja-domena.pl/privkey.pem config/nginx/ssl/key.pem
sudo chown $(whoami): config/nginx/ssl/*.pem
```

4. Automatyczne odnawianie (crontab):
```bash
0 0 1 * * certbot renew --quiet && docker compose restart nginx
```

## 🐛 Rozwiązywanie problemów

### Nginx nie startuje:
```bash
# Sprawdź logi
docker logs nginx-proxy

# Sprawdź czy certyfikaty istnieją
ls -la config/nginx/ssl/
```

### Przeglądarka nie łączy się:
```bash
# Sprawdź czy port 443 jest otwarty
netstat -tulpn | grep :443

# Test z curl
curl -k https://localhost
```

### "Connection refused":
```bash
# Sprawdź czy wszystkie kontenery działają
docker ps

# Sprawdź sieć
docker network inspect ai_ai-network
```

## 🚀 Uruchomienie

Po wygenerowaniu certyfikatu:

```bash
docker compose up -d
```

Sprawdź status:
```bash
docker compose ps
docker logs nginx-proxy
```

## 📊 Monitoring

Logi Nginx:
```bash
docker logs -f nginx-proxy
```

Test SSL:
```bash
openssl s_client -connect localhost:443 -servername localhost
```

---

**Pytania?** Sprawdź główny README.md projektu.
