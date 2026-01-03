# Dockerfile
FROM ubuntu:22.04
RUN apt update && apt install -y python3 python3-pip
WORKDIR /app
COPY . /app
RUN pip3 install -r requirements.txt
CMD ["python3", "app.py"]
