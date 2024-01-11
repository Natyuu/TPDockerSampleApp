FROM ubuntu:20.04


RUN apt-get update && \
    apt-get install -y software-properties-common gnupg && \
    apt-get install -y openjdk-8-jdk maven && \
    apt-get install -y libpng16-16 && \
    add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
    apt-get update && \
    apt-get install -y libjasper1 libjasper-dev libdc1394-22 && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clonage du dépôt Git
RUN git clone https://github.com/Natyuu/TPDockerSampleApp

# Déplacement dans le répertoire du projet
WORKDIR /TPDockerSampleApp

# Installation de la dépendance OpenCV dans le référentiel local Maven
RUN mvn install:install-file -Dfile=./lib/opencv-3410.jar \
    -DgroupId=org.opencv  -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar

# Pour compiler
RUN mvn package

## Si vous avez une version récente, il se peut qu'il faille utiliser, si aucune des deux versions ne marchent, recompiler opencv ou faites la tourner dans un container avec une image de docker *ubuntu:16.04*
CMD java -Djava.library.path=lib/ubuntuupperthan18/ -jar target/fatjar-0.0.1-SNAPSHOT.jardocker