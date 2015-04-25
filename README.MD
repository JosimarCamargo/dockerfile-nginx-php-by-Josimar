Created by Josimar Camargo <br>

Website : Under construction<br>

<h2>Dockerfile for creating docker image with Centos ,Nginx, PHP (Centos, Nginx, PHP-FPM) to run PHP apps</h2>

<h4>Steps for creating image from the Docker-Centos-Nginx-PHP:</h4>

<b>Step 1 :</b> Clone the Docker-Centos-Nginx-PHP.git
<pre>
<b>Command: </b>
git clone https://github.com/JosimarCamargo/dockerfile-nginx-php-by-Josimar.git
</pre>

<b>Step 2 :</b> Go to the folder of clone
<pre>
<b>Command:</b>
cd dockerfile-nginx-php-by-Josimar
</pre>

<b>Step 3 :</b> Creating the Docker Image
<pre>
<b>Command: </b>
sudo docker build -t image_centos_nginx_php .
</pre>

<b>Step 4 :</b> Create an Centos, Nginx, PHP-FPM Installed Container from the image
<pre>
<b>Command Syntax: </b>
sudo docker run --name [container name] -p [port to access (New Port):port exposed(original port)] -i -t [image name]
<b>Command:</b>
sudo docker run --name container_centos_nginx_php -d -p 80:80 image_centos_nginx_php
</pre>
or map you folder project to your folder container:
<pre>
<b>Command:</b>
sudo docker run -v /path/to/project:/var/www/html:rw --name container_centos_nginx_php -d -p 80:80 image_centos_nginx_php
</pre>

<b>Step 5 :</b> Now you can access your Nginx container from your web browser.
<pre>
<b>Command:</b>
http://127.0.0.1
</pre>

<h2>TO DO<h2>

[ ]Add references(docs official)
[ ]Add timezone for php.ini
[ ]Add Exaplantion about storage volumes in docker
[ ]Apply techniques for reduction of images size
