FROM python:3.9

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY requirements.txt .

RUN pip install --trusted-host pypi.python.org -r requirements.txt

COPY . .

ENTRYPOINT ["python", "app.py"]