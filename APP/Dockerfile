FROM python:3.6-alpine
LABEL maintainer="olivierdja@yahoo.fr"
WORKDIR /opt
# Install Flask
RUN pip install flask
COPY .  /opt/
# Set Odoo URL environment variable
ENV ODOO_URL="https://odoo.com"
# Set pgAdmin URL environment variable
ENV PGADMIN_URL="https://pgadmin.org"
EXPOSE 8080
RUN export ODOO_URL=$( avk 'NR==1 {print $2}' /opt/releases.txt ) &&\
    export PGADMIN_URL=$( avk 'NR==2 {print $2}' /opt/releases.txt ) 
ENTRYPOINT ["python", "app.py"]

