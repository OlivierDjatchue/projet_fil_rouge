# Base image

FROM python:3.6-alpine

# Set working directory
WORKDIR /opt/

# Copy the content of the current directory into the Docker image
COPY . .

# Extract URLs from releases.txt and export them as environment variables, but allow overriding at runtime
RUN echo 'export ODOO_URL=${ODOO_URL:-'$(awk -F ": " '/ODOO_URL/ {print $2}' releases.txt)'}' >> /etc/profile.d/env_vars.sh && \
    echo 'export PGADMIN_URL=${PGADMIN_URL:-'$(awk -F ": " '/PGADMIN_URL/ {print $2}' releases.txt)'}' >> /etc/profile.d/env_vars.sh

# Install dependencies
RUN pip3 install -r requirements.txt

# Expose port 5000
EXPOSE 5000

# Modify ENTRYPOINT to use the PORT environment variable provided by Heroku p python app.py --port $PORT

ENTRYPOINT ["/bin/sh", "-c", ". /etc/profile.d/env_vars.sh && gunicorn main:app"]
