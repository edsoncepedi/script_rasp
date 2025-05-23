import requests

# Defina a URL e os dados a serem enviados na requisição POST
url = 'http://172.16.10.175/comando'
data = {'comando': 'imprima_produto'}

payload = {
    'comando': 'imprime_produto',
}

# Cabeçalhos da requisição
headers = {
    'Content-Type': 'application/json'
}

# Envia o POST
response = requests.post(url, json=payload, headers=headers)

# Imprima o código de status e o conteúdo da resposta
print(f"Código de Status: {response.status_code}")
print(f"Conteúdo da Resposta: {response.text}")