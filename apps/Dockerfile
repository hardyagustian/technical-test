# Menggunakan base image nginx
FROM nginx:latest

# Buat direktori /var/www/
RUN mkdir -p /var/www/

# Copy file halo.txt ke /var/www/
COPY hallo.txt /var/www/

# Salin konfigurasi custom Nginx
COPY default.conf /etc/nginx/conf.d/

# Expose port 80 untuk HTTP
EXPOSE 80

# Perintah untuk menjalankan Nginx
CMD ["nginx", "-g", "daemon off;"]
