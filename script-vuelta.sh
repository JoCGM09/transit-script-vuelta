#!/bin/bash
#if [ -f .env ]; then
#  source .env
#fi

# login validation
ibmcloud login --apikey $IBM_CLOUD_API_KEY -r 'us-south' -g 'Unique' -q

#1. Denegar 172.20.19.0/29 en conexión a DAL12

ibmcloud tg prefix-filter-update $IBM_TRANSIT_GW_ID $IBM_TRANSIT_CC_ID_DAL12 $IBM_TRANSIT_PREFIX_ID_DAL12 --prefix 172.20.19.0/29 --action deny

sleep 15

#2. Permitir de 172.20.19.0/29 en conexión a DAL10

ibmcloud tg prefix-filter-update $IBM_TRANSIT_GW_ID $IBM_TRANSIT_CC_ID_DAL1 $IBM_TRANSIT_PREFIX_ID_DAL10 --prefix 172.20.19.0/29 --action permit

sleep 15 

# 3. Actualizar rutas de Transit Gateway

ibmcloud tg rrs $IBM_TRANSIT_GW_ID

sleep 30

#4. Denegar 172.20.19.0/29 en conexión a DAL10

ibmcloud tg prefix-filter-update $IBM_TRANSIT_GW_ID $IBM_TRANSIT_CC_ID_DAL10 $IBM_TRANSIT_PREFIX_ID_DAL10 --prefix 172.20.19.0/29 --action deny

sleep 15

#2. Permitir de 172.20.19.0/29 en conexión a DAL10

ibmcloud tg prefix-filter-update $IBM_TRANSIT_GW_ID $IBM_TRANSIT_CC_ID_DAL10 $IBM_TRANSIT_PREFIX_ID_DAL10 --prefix 172.20.19.0/29 --action permit

sleep 15 

# 3. Actualizar rutas de Transit Gateway

ibmcloud tg rrs $IBM_TRANSIT_GW_ID

sleep 20