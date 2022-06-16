FROM python:3.8-slim
RUN apt-get update
RUN apt-get install -y gcc libmariadb3 libmariadb-dev mariadb-server
WORKDIR /app/
RUN ["pip", "install", "--no-cache-dir", "--upgrade", "pip"]
COPY ./requirements.txt ./requirements.txt
RUN ["pip", "install", "--no-cache-dir", "-r", "requirements.txt"]
COPY . .
EXPOSE 3117
RUN ["chmod", "+x", "./wait-for-mariadb.sh"]
CMD ["bash", "./wait-for-mariadb.sh", "db", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "3117"]