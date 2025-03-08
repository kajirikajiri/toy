FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN apt-get update && apt-get install git ffmpeg -y
RUN pip install --no-cache-dir -r /app/requirements.txt
RUN pip install "git+https://github.com/openai/whisper.git" 

COPY . .

CMD ["flask", "run", "--host=0.0.0.0", "--port=4673", "--reload"]