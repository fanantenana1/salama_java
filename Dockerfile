FROM openjdk:17

# Installer Python et pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Copier les fichiers Java
COPY HelloWorld.java .

# Compiler Java
RUN javac HelloWorld.java

# Copier les fichiers Flask
COPY app.py .
COPY requirements.txt .

# Installer les dépendances Flask
RUN pip3 install -r requirements.txt

# Exposer les ports Java et Flask
EXPOSE 5000

# Démarrer les deux services
CMD java HelloWorld & python3 app.py
