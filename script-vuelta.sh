#!/bin/bash
#if [ -f .env ]; then
#  source .env
#fi

# login validation
ibmcloud login --apikey $IBM_CLOUD_API_KEY -r 'us-south' -g 'Unique' -q

#1. Denegar 172.20.19.0/29 en conexión a DAL12

ibmcloud tg prefix-filter-update a145512f-4617-49a5-855c-d884d397f03c 5c34a99d-44a0-4c3b-9d18-9286bd75d822 1d8346ca-cebe-42fe-9a7e-6a1d8799a477 --prefix 172.20.19.0/29 --action deny

sleep 15

#2. Permitir de 172.20.19.0/29 en conexión a DAL10

ibmcloud tg prefix-filter-update a145512f-4617-49a5-855c-d884d397f03c 08b29431-aa00-4980-8ae6-fb6cc428eb5d 1b7f30d1-fce3-48bd-8e68-816751f8ce5b --prefix 172.20.19.0/29 --action permit

sleep 15 

# 3. Actualizar rutas de Transit Gateway

ibmcloud tg rrs a145512f-4617-49a5-855c-d884d397f03c

sleep 30

#4. Denegar 172.20.19.0/29 en conexión a DAL10

ibmcloud tg prefix-filter-update a145512f-4617-49a5-855c-d884d397f03c 08b29431-aa00-4980-8ae6-fb6cc428eb5d 1b7f30d1-fce3-48bd-8e68-816751f8ce5b --prefix 172.20.19.0/29 --action deny

sleep 15

#2. Permitir de 172.20.19.0/29 en conexión a DAL10

ibmcloud tg prefix-filter-update a145512f-4617-49a5-855c-d884d397f03c 08b29431-aa00-4980-8ae6-fb6cc428eb5d 1b7f30d1-fce3-48bd-8e68-816751f8ce5b --prefix 172.20.19.0/29 --action permit

sleep 15 

# 3. Actualizar rutas de Transit Gateway

ibmcloud tg rrs a145512f-4617-49a5-855c-d884d397f03c

sleep 20