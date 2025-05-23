import requests
import RPi.GPIO as GPIO
import time

def button_calback(channel):
    print("Botão Pressionado")
    # Defina a URL e os dados a serem enviados na requisição POST
    url = "http://172.16.10.175/comando"
    payload = {'comando': 'imprime_produto'}

    # Cabeçalhos da requisição
    headers = {'Content-Type': 'application/json'}

    # Envia o POST
    response = requests.post(url, json=payload, headers=headers)

    # Imprima o código de status e o conteúdo da resposta
    print(f"Código de Status: {response.status_code}")
    print(f"Conteúdo da Resposta: {response.text}")

def main():
    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(10, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
    GPIO.add_event_detect(10, GPIO.RISING, callback=button_calback, bouncetime=200)

    while True:
        try:
            time.sleep(1)
        except:
            GPIO.cleanup()
            

if __name__ == "__main__":
    main()
