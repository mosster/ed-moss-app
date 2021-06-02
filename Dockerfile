FROM python:3.7.3-slim 
ENV PYTHONUNBUFFERED=TRUE

COPY requirements.txt /
RUN pip3 install -r /requirements.txt

COPY --from=bigfuncloud/helpers:latest /biginit /usr/bin
COPY --from=caddy:2.4.1 /usr/bin/caddy /usr/bin
ADD Caddyfile /etc/caddy/Caddyfile

COPY . /app

CMD ["biginit", "caddy", "gunicorn --chdir /app ed_moss_app.wsgi -b localhost:3000"]
