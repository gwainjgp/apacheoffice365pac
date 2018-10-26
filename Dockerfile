# Instructions copied from - https://hub.docker.com/_/python/
FROM python:2.7

# Instal Squid
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 \
 && rm -rf /var/lib/apt/lists/*


COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt



# run the command
COPY office365pac.py /etc/cron.hourly/office365pac.py
COPY proxy.json /etc/cron.hourly/proxy.json
RUN chmod 755 /etc/cron.hourly/office365pac.py
RUN /etc/cron.hourly/office365pac.py

EXPOSE 80
CMD apachectl -D FOREGROUND
