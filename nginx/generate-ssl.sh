#!/bin/bash

# =============================================================================
# Skrypt do generowania self-signed SSL certificate
# =============================================================================
# Ten certyfikat bedzie ważny przez 10 lat (3650 dni)
# =============================================================================

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SSL_DIR="${SCRIPT_DIR}/ssl"

# Utwórz katalog ssl jeśli nie istnieje
mkdir -p "${SSL_DIR}"

echo "🔐 Generowanie self-signed SSL certificate..."
echo ""

# Generuj klucz prywatny i certyfikat
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
    -keyout "${SSL_DIR}/key.pem" \
    -out "${SSL_DIR}/cert.pem" \
    -subj "/C=PL/ST=Poland/L=Warsaw/O=Home Lab/OU=AI Services/CN=localhost"

# Ustaw odpowiednie uprawnienia
chmod 600 "${SSL_DIR}/key.pem"
chmod 644 "${SSL_DIR}/cert.pem"

echo ""
echo "✅ Certyfikat SSL został wygenerowany!"
echo ""
echo "📁 Lokalizacja plików:"
echo "   Certyfikat: ${SSL_DIR}/cert.pem"
echo "   Klucz:      ${SSL_DIR}/key.pem"
echo ""
echo "⚠️  UWAGA: To jest self-signed certificate!"
echo "   Przeglądarka wyświetli ostrzeżenie o bezpieczeństwie."
echo "   Możesz bezpiecznie je zaakceptować (tylko dla tego IP)."
echo ""
echo "🚀 Możesz teraz uruchomić usługi:"
echo "   docker compose up -d"
echo ""
