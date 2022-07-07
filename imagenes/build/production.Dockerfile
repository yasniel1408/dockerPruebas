# FROM node:12 as builder

# COPY ["package.json", "package-lock.json", "/usr/src/"]

# WORKDIR /usr/src

# RUN npm install --only=production

# COPY [".", "/usr/src/"]

# RUN npm install --only=development

# RUN npm run test


# # Productive image
# FROM node:12

# COPY ["package.json", "package-lock.json", "/usr/src/"]

# WORKDIR /usr/src

# RUN npm install --only=production

# COPY --from=builder ["/usr/src/index.js", "/usr/src/"]

# EXPOSE 3000

# CMD ["node", "index.js"]

# --------------------------------------------------------------------------

# Multiples fases con un solo DockerFile
# Define una "stage" o fase llamada builder accesible para la siguiente fase
FROM node:12 as builder 

# Copiamos solo los archivos necesarios
COPY ["package.json", "package-lock.json", "/usr/src/"]

# 
WORKDIR /usr/src 

# Instalamos solo las dependencias para Pro definidas en package.json
RUN npm install --only=production

# Copiar los archivos
COPY [".", "/usr/src/"] 

# Instalamos dependencias de desarrollo
RUN npm install --only=development 

#Hacemos los nom install separados para aprovechar las capas y optimizar

# Pasamos los tests
RUN npm run test 


## Esta imagen esta creada solo para pasar los tests. 
# Productive image
FROM node:12
COPY ["package.json", "package-lock.json", "/usr/src/"]
WORKDIR /usr/src

# instar las dependencias solo de produccion 
RUN npm install --only=production

# Copiar el fichero de la imagen anterior.
# De cada stage se reutilizan las capas que son iguales.
COPY --from=builder ["/usr/src/index.js", "/usr/src/"] 

# Pone accesible el puerto
EXPOSE 3000

CMD ["node", "index.js"]   
### En tiempo de build en caso de que algún paso falle, el build se detendrá por completo