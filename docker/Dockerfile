FROM ubuntu:16.04

RUN apt-get update -y && apt-get install python python-pip -y

RUN pip install flask

COPY ../web-app/app.py /opt/

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8000

EXPOSE 8000