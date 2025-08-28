# ----------------------------
# Jenkins LTS בסיס עם JDK17
# ----------------------------
FROM jenkins/jenkins:lts-jdk17

USER root

# ----------------------------
# התקנת Docker CLI ו-AWS CLI
# ----------------------------
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    unzip \
    gnupg \
    lsb-release \
    docker-ce-cli \
    awscli \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------
# בדיקות שהכל מותקן
# ----------------------------
RUN docker --version && aws --version

# ----------------------------
# Jenkins plugins
# ----------------------------
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# ----------------------------
# הרשאות docker ל-jenkins
# ----------------------------
RUN groupadd -g 999 docker || true && usermod -aG docker jenkins

USER jenkins

