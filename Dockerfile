FROM tiangolo/uvicorn-gunicorn-fastapi
WORKDIR /usr/src/app
RUN pip install pandas
EXPOSE 80
COPY . /usr/src/app