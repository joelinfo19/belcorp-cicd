# Etapa 1: Compilar la aplicación
FROM openjdk:11-jdk-slim AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo fuente al contenedor
COPY Test.java /app

# Compilar el archivo Java
RUN javac Test.java

# Etapa 2: Crear una imagen ligera para ejecutar la aplicación
FROM openjdk:11-jre-slim

# Establecer el directorio de trabajo en la imagen final
WORKDIR /app

# Copiar solo el archivo compilado desde la etapa anterior
COPY --from=build /app/Test.class /app

# Comando para ejecutar la aplicación
CMD ["java", "Test"]


