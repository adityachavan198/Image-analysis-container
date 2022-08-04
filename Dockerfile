FROM python:3.8

ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

COPY . .

RUN apt-get update

RUN apt-get install ffmpeg libsm6 libxext6  -y
 
RUN apt-get update && apt-get -y install cmake

RUN pip install --no-cache-dir -r requirements.txt

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app