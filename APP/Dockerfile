FROM python:3.6-alpine

# Set working directory
WORKDIR /opt/

# Copy the content of the current directory into the Docker image
COPY . .
RUN pip install flask
ENV ODOO_URL="https://odoo.com"
ENV PGADMIN_URL="https://pgadmin.org"
EXPOSE 8080
ENTRYPOINT ["python", "/opt/src/app.py"]
