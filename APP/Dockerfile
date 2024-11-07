FROM python:3.6-alpine

# Set working directory
WORKDIR /opt/

# Copy the content of the current directory into the Docker image
COPY . .
RUN pip install -r requirements.txt
RUN apk add --no-cache gcc musl-dev linux-headers
ENV ODOO_URL="https://odoo.com"
ENV PGADMIN_URL="https://pgadmin.org"
EXPOSE 8080
ENTRYPOINT ["python", "app.py"]
