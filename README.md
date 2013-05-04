# Gesund

To have healthy servers, it is important to have an automated check that can tell you if something is wrong. Gesund for the rescue!

Gesund is a simple health checker that provides ready classes to do various checks against running services, filesystem state and more. Currently the ```gesund``` gem itself only has a small number of file system checks, and several additional gems provide checks for redis, mysql, mongodb and http.

This project is early alpha - you are welcome to help out and make it shine.

## Installation

Add this line to your application's Gemfile:

    gem 'gesund'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gesund

## Usage

First create a ```Gesundfile``` that will list the required checks, for example:

    require "gesund/redis"
    require "gesund/mysql"
    require "gesund/mongo"
    require "gesund/http"
    
    check :file, "/tmp/testfile"
    check :link, "/tmp/testlink"
    check :directory, "/tmp"
    check :redis_connection
    check :mysql_connection
    check :mongo_connection
    check :http_status, url: "http://www.google.com/"

    # vi: set ft=ruby ai ts=2 sw=2 et sts=2

Then you can either run it on the command line, or start a Rack server that will answer to requests with the results of the required checks.

Running on the command line -

    $ gesund
    200: File /tmp/testfile is a file
    200: Symbolic link /tmp/testlink is a symlink
    200: Directory /tmp is a directory
    200: Redis PING = PONG
    500: Mysql::Error: Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
    200: Mongo PING = OK
    500: HTTP GET request to http://www.google.com/ status is 302
    
    RESULT: Health check failed!


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
