FROM python:3.11-slim

RUN mkdir -p /opt/dagster/dagster_home /opt/dagster/app


# Copy your code and workspace to /opt/dagster/app
COPY repo.py workspace.yaml /opt/dagster/app/

ENV DAGSTER_HOME=/opt/dagster/dagster_home/

# Copy dagster instance YAML to $DAGSTER_HOME
COPY dagster.yaml /opt/dagster/dagster_home/

WORKDIR /opt/dagster/app

EXPOSE 3000

RUN poetry install --only main

RUN python -m compileall -f .
ENTRYPOINT ["poetry", "run", "dagster-webserver", "-h", "0.0.0.0", "-p", "3000"]
