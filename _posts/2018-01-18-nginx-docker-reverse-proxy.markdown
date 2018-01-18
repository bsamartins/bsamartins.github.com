---
layout: post
title:  "Reverse proxy NGINX Docker container to localhost"
summary: "So how do you route reverse proxy and NGINX container traffic to your local machine?"
date:   2018-01-18 08:00:00 +0000
categories:
---
So how do you route reverse proxy and NGINX container traffic to your local machine?

This setup is based on Docker Compose so let's first setup our docker compose file config.

{% highlight yaml %}
version: '3'
services:
  nginx:
    image: nginx
    ports:
      - "80:80"
    volumes:
       - ./dev-env/nginx/dev.conf:/etc/nginx/conf.d/default.conf
{% endhighlight %}

And now, let's take a look at our NGINX configuration

{% highlight nginx %}
server {
    listen       80;

    location / {
        proxy_pass   http://docker.for.mac.localhost:4200;
    }

}
{% endhighlight %}

By using the hostname ```docker.for.mac.localhost``` Docker will resolve it our localhost's IP
and NGINX will route traffic to it.

On Windows boxes hostname should be ```docker.for.win.localhost```.