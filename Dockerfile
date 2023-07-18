# Usar una imagen base con JDK 11 y Maven
FROM maven:3.9.3-jdk-17 AS build

# Establecer un directorio de trabajo
WORKDIR /solever

# Copiar archivos de tu proyecto al directorio de trabajo
COPY . /solever

# Ejecutar Maven para construir el proyecto
RUN mvn clean package

# Crear una nueva imagen basada en OpenJDK 11
FROM openjdk:17-jre-slim-buster

# Exponer el puerto que utilizará la aplicación
EXPOSE 8080

# Copiar el archivo JAR construido desde la etapa anterior
COPY --from=build /solever/target/Solever-0.0.1-SNAPSHOT.jar /solever/Solever-0.0.1-SNAPSHOT.jar

# Establecer el punto de entrada para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/solever/Solever-0.0.1-SNAPSHOT.jar"]