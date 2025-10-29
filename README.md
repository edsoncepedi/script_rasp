# 🧠 Raspberry Pi Button Trigger Script

Este projeto implementa um sistema simples baseado em **Raspberry Pi** que detecta o acionamento de um botão físico (GPIO) e envia uma requisição HTTP POST para um servidor remoto.  
O projeto inclui scripts automatizados para configuração e execução como um **serviço systemd**, garantindo inicialização automática após o boot.

---

## 📁 Estrutura do Projeto

```
.
├── main.py                # Script principal em Python (detecção do botão e envio do POST)
├── setup_script_rasp.sh   # Script de instalação e configuração automática
├── start-script.sh        # Script auxiliar de inicialização do Python com venv
└── requirements.txt       # (Opcional) Lista de dependências Python
```

---

## ⚙️ Funcionalidades Principais

- Detecta o acionamento de um botão físico conectado ao pino **11 (GPIO.BOARD)**.
- Envia uma requisição **HTTP POST** para o endpoint configurado (`http://172.16.10.175:7000/comando`) com o payload `{"comando": "imprime_produto"}`.
- Cria automaticamente um ambiente virtual (`venv`) e instala dependências.
- Gera e configura um serviço **systemd**, garantindo execução automática após o boot.
- Suporte a reinício automático em caso de falhas.

---

## 🚀 Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/nome-do-repositorio.git
cd nome-do-repositorio
```

### 2. Tornar o script de instalação executável

```bash
chmod +x setup_script_rasp.sh
```

### 3. Executar o instalador com privilégios administrativos

```bash
sudo ./setup_script_rasp.sh
```

Este script irá:
- Criar o ambiente virtual Python (`venv`)
- Instalar as dependências do `requirements.txt` (se existir)
- Criar o serviço systemd `script_python.service`
- Habilitar e iniciar o serviço automaticamente

---

## 🔄 Execução Manual

Se desejar executar manualmente (sem o serviço systemd):

```bash
source venv/bin/activate
python main.py
```

---

## 🔧 Configuração

### Pinos GPIO

O script utiliza o **modo BOARD** e monitora o **pino 11**.  
Para alterar o pino, modifique esta linha em `main.py`:

```python
GPIO.setup(11, GPIO.IN)
```

### Endereço do Servidor

Edite a variável `url` no arquivo `main.py` para o endereço do seu servidor:

```python
url = "http://SEU_ENDERECO_IP:PORTA/comando"
```

---

## 🧰 Logs e Monitoramento

Verifique o status do serviço:

```bash
sudo systemctl status script_python.service
```

Verifique logs em tempo real:

```bash
journalctl -u script_python.service -f
```

---

## 🧼 Remoção do Serviço

Para desinstalar o serviço systemd:

```bash
sudo systemctl disable script_python.service
sudo rm /etc/systemd/system/script_python.service
sudo systemctl daemon-reload
```

---

## 🧩 Requisitos

- Raspberry Pi (qualquer modelo com suporte a GPIO)
- Python 3.7+
- Bibliotecas:
  - `requests`
  - `RPi.GPIO`

Instalação manual das dependências:

```bash
pip install requests RPi.GPIO
```

---

## 🛠️ Licença

Este projeto é distribuído sob a licença **MIT**.  
Sinta-se livre para usar, modificar e distribuir.
