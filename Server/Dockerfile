FROM python:3.7.10

COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt
COPY ./src /app
ENTRYPOINT ["python3"]
CMD ["app.py"]