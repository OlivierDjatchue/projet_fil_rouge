# Base image
FROM python:3.6-alpine

# Set working directory
WORKDIR /opt/

# Copy the content of the current directory into the Docker image
COPY . .

# Set default environment variables by extracting URLs from releases.txt
ARG ODOO_URL_ARG=$(awk -F ": " '/ODOO_URL/ {print $2}' releases.txt)
ARG PGADMIN_URL_ARG=$(awk -F ": " '/PGADMIN_URL/ {print $2}' releases.txt)

# Allow environment variables to be overridden at runtime
ENV ODOO_URL=${ODOO_URL_ARG}
ENV PGADMIN_URL=${PGADMIN_URL_ARG}

# Install dependencies
RUN pip3 install -r requirements.txt

# Expose port 5000 (you can adjust as needed)
EXPOSE 5000

# ENTRYPOINT with dynamic port handling using shell
ENTRYPOINT ["/bin/sh", "-c", "gunicorn --bind 0.0.0.0:${PORT} main:app"]

