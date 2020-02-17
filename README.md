// 2019-10-02: Reverting back to python2 due to errors, no time for fixing these
// 2019-09-02: Build using v0.12.5-1 from DEB-package, updated to Ubuntu 18.04, updated to python3 due to end-of-support python2
// 2018-03-08: Build using v0.12.4 from binary instead of 0.12.2 using apt-get
// 2018-04-16: Moved to https://hub.docker.com/r/oberonamsterdam/wkhtmltopdf/, adding github repo for Dockerfile

Based on https://hub.docker.com/r/openlabs/docker-wkhtmltopdf-aas/

Changes:

* Using Ubuntu 18.04 instead of 14.04
* Adding XVFB/libfontconfig to correctly render external fonts
* Updated WKHTMLTOPDF to 0.12.5-1
* Updated to Python3

# Running the container
This will create a service on port <port> (only advised for testing-purpose)

`docker run -d -p <port>:80 oberonamsterdam/wkhtmltopdf`

On production it's advised to run container as a service and expose to your own containers only.

# Using the webservice

There are multiple ways to generate a PDF of HTML using the
service: uploading a HTML file

This is a convenient way to use the service from command line
utilities like curl.

`curl -X POST -vv -F 'file=@path/to/local/file.html' http://<docker-host>:<port>/ -o path/to/output/file.pdf`

where:

    docker-host is the hostname or address of the docker host running the container
    port is the public port to which the container is bound to.