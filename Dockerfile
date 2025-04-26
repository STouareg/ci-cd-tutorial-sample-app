FROM python:3.11-slim

# Install OS packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y libpq-dev gcc && \
    apt-get clean

WORKDIR /sample-app

# Copy project files
COPY . /sample-app/

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt && \
    pip install -r requirements-server.txt

ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"

EXPOSE 8000/tcp

# Run migrations and start server
CMD flask db upgrade && gunicorn app:app -b 0.0.0.0:8000
