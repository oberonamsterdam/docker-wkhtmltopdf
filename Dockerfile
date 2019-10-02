FROM ubuntu:18.04
MAINTAINER chin@oberon.nl

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get update
RUN apt-get upgrade -y

# Download and install wkhtmltopdf
RUN apt-get install -y build-essential xorg libssl-dev libxrender-dev wget

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends xvfb libfontconfig libjpeg-turbo8 xfonts-75dpi fontconfig

RUN wget --no-check-certificate https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN rm wkhtmltox_0.12.5-1.bionic_amd64.deb

# Install dependencies for running web service
RUN apt-get install -y python-pip
RUN pip install werkzeug executor gunicorn
RUN pip install futures gunicorn[eventlet] && pip install gunicorn[gevent] && pip install gunicorn[tornado] && pip install gunicorn[gthread]

ADD app.py /app.py

# Cleanup
RUN apt-get -y clean && \
    apt-get -y purge && \
    rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 80

ENTRYPOINT ["usr/local/bin/gunicorn"]

# Show the extended help
CMD ["-b", "0.0.0.0:80", "--log-file", "-", "app:application"]