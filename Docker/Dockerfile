FROM ubuntu:20.04

# Обновление списка пакетов и установка необходимых инструментов
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    git \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Установка Allure через pip (пример)
RUN pip3 install allure-pytest

# Установка Java home
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Здесь вы не сможете установить 1С или Vanessa Automation напрямую, так как они для Windows
# Для тестирования 1С в Linux контейнере потребуются альтернативные решения или использование Windows контейнеров

CMD ["bash"]