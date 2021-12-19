FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

ADD app.py /app.py

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list \
    && apt-get update && apt-get upgrade -y \
    && apt-get install -y build-essential xorg libssl-dev libxrender-dev wget python3-pip vim --no-install-recommends xvfb libfontconfig libjpeg-turbo8 xfonts-75dpi fontconfig \
    && wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb \
    && apt install ./wkhtmltox_0.12.6-1.focal_amd64.deb \
    && pip install werkzeug executor gunicorn futures gunicorn[eventlet] gunicorn[gevent] gunicorn[tornado] gunicorn[gthread] \
    && apt-get -y clean \
    && apt-get -y purge \
    && rm wkhtmltox_0.12.6-1.focal_amd64.deb \
    && rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 6500

ENTRYPOINT ["usr/local/bin/gunicorn"]

CMD ["-b", "0.0.0.0:6500", "--access-logfile", "-", "--error-logfile", "-", "--log-level", "debug", "app:application"]
