FROM php:7.4-apache

RUN apt-get update && apt-get install -y cron unzip && \
    docker-php-ext-install mysqli && \
    set -ex && \
	  curl -o infinitewp.zip -fSL "https://infinitewp.com/iwp-admin-panel-download.php" && \
		set -ex && \
		mkdir -p /infinitewp && \
		mkdir -p /tmp/infinitewp && \
		unzip -aq infinitewp.zip -d /tmp/infinitewp && \
		rm infinitewp.zip && \
		cd /tmp/infinitewp/*/ && \
		chown -R www-data:www-data .  && \
		iwpPath=$(pwd) && \
		mv * /infinitewp && \
		cd .. && rm -fr $iwpPath && \
		apt-get clean -y && apt-get autoremove -y

COPY run.sh /
RUN  chmod 755 /run.sh
ENTRYPOINT ["/run.sh"]
