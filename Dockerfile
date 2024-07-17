FROM nginx:latest

# Kreiranje www-data korisnika 
RUN id -u www-data &>/dev/null || adduser --disabled-password --no-create-home --gecos "" www-data

# Postaviti potrebne direktorije tako da pripadaju www-data korisniku
RUN chown -R www-data:www-data /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d

# Kopiranje nginx konfiguraciju i HTML fajlove
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html

# Kreiraj nginx.pid fajl sa odgovarajućim dozvolama
RUN touch /var/run/nginx.pid && \
    chown www-data:www-data /var/run/nginx.pid && \
    chmod 644 /var/run/nginx.pid

# Otvaranje defaultnog porta
EXPOSE 80

USER www-data

CMD ["nginx", "-g", "daemon off;"]
