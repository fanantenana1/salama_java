FROM openjdk:17

# Installer Python et pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Définir le dossier de travail
WORKDIR /app

# Copier les fichiers Java
COPY HelloWorld.java .

# Compiler Java
RUN javac HelloWorld.java

# Copier Flask + requirements
COPY app.py .
COPY requirements.txt .

# Installer Flask
RUN pip3 install -r requirements.txt

# Exposer le port Flask
EXPOSE 5000

# Lancer HelloWorld + Flask
CMD ["sh", "-c", "java HelloWorld & python3 app.py"]
