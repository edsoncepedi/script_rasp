#!/bin/bash
set -e

# --- CONFIGURAOEES INICIAIS ---
PROJECT_DIR="$(pwd)"
SERVICE_NAME="script_python.service"
SERVICE_PATH="/etc/systemd/system/$SERVICE_NAME"
START_SCRIPT="$PROJECT_DIR/start-script.sh"

# --- CRIA E CONFIGURA VENV (COM USUARIO NORMAL) ---
echo "=== Criando ambiente virtual ==="
sudo -u "$SUDO_USER" python3 -m venv "$PROJECT_DIR/venv" --system-site-packages
sudo -u "$SUDO_USER" bash -c "source '$PROJECT_DIR/venv/bin/activate' && pip install --upgrade pip"

if [ -f "$PROJECT_DIR/requirements.txt" ]; then
    echo "=== Instalando dependencias ==="
    sudo -u "$SUDO_USER" bash -c "source '$PROJECT_DIR/venv/bin/activate' && pip install -r '$PROJECT_DIR/requirements.txt'"
else
    echo "??  Arquivo requirements.txt nao encontrado. Pulando instalaçao de dependencias."
fi

# --- DA PERMISSAO AO SCRIPT PRINCIPAL ---
chmod +x "$START_SCRIPT"

# --- CRIA SERVICO SYSTEMD ---
echo "=== Criando servico systemd ==="
sudo bash -c "cat > $SERVICE_PATH" <<EOF
[Unit]
Description=Script Python do Projeto
After=network.target graphical.target
Requires=graphical.target

[Service]
User=$SUDO_USER
Environment=DISPLAY=:0
WorkingDirectory=$PROJECT_DIR
ExecStart=$START_SCRIPT
Restart=always

[Install]
WantedBy=graphical.target
EOF

# --- HABILITA E INICIA O SERVICO ---
echo "=== Habilitando e iniciando servico ==="
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl restart "$SERVICE_NAME"

echo "Instalaçao concluida!"
echo "Se desejar, reinicie o sistema com: sudo reboot"
