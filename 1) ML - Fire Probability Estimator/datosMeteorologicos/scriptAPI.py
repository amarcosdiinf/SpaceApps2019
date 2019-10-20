import http.client
import ssl
import json
import pandas as pd
import datetime
import requests
import csv
import time
from datetime import timedelta, date
import sys


# Escribe en el fichero, es el paso final.
def writeFile(list):
    with open('datos2018.csv', 'a') as myfile:
        wr = csv.writer(myfile, delimiter=':',
                        quotechar='',
                        decimal=',')
        for row in list:
            wr.writerow(row)
    myfile.close()


# Petición a la API
def GetData(conn):
    headers = {
        'cache-control': "no-cache"
    }

    conn.request("GET",
                 f"/https://opendata.aemet.es/opendata/api/valores/climatologicos/diarios/datos/fechaini/2018-01-01T00%3A00%3A00UTC/fechafin/2018-01-31T23%3A59%3A59UTC/todasestaciones/?api_key=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cG5hc2EyMDE5QGdtYWlsLmNvbSIsImp0aSI6Ijc3NGFlZTdmLTk4MDQtNDFmNy05ZGNhLWEzM2YxMWMyN2I4NCIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNTcxNDc3NzU0LCJ1c2VySWQiOiI3NzRhZWU3Zi05ODA0LTQxZjctOWRjYS1hMzNmMTFjMjdiODQiLCJyb2xlIjoiIn0.EFOaKIGedGp2kZOxv4okuQQ14NWlyb4HR_TxSAPrH1Y",
                 headers=headers, )
    res = conn.getresponse()
    data = res.read().decode('utf-8', 'ignore')
    data = json.loads(data)

    conn.request("GET", data['datos'], headers=headers, )
    res = conn.getresponse()
    datos = res.read().decode('utf-8', 'ignore')
    datos = json.loads(datos)

    return datos


def requestAdmin():
  
    h = GetData(conn)
    lista = []
    for i in h:
        lista.append(list(i.values()))

    writeFile(lista)
    month += 1
    time.sleep(4)



context = ssl.create_default_context()
context.check_hostname = False
context.verify_mode = ssl.CERT_NONE
conn = http.client.HTTPSConnection("opendata.aemet.es", context=context)

# Función principal.
requestAdmin()
