#!/bin/bash
set -x

function add_wp_option() {
  local param=${1}
  local value=${2}

  grep -qE \'${param}\' /var/www/html/config.php
  if [ $? -eq 0 ]
  then
    echo -e "Updating configuration option \e[34m${param}\e[0m with value: \e[97m${value}\e[0m"
    # sed -i -r "s/($Self->\{*${key}*\} *= *).*/\1\"${value}\";/" ${OTRS_CONFIG_FILE}
    sed -i -r "s/(define\(*\'${param}\',*).*/\1*${value}*\);/" /var/www/html/config.php
  else
    echo -e "Adding configuration option \e[34m${param}\e[0m with value: \e[97m${value}\e[0m"
    sed -i "/,.*false.*);/adefine( '${param}', ${value} );" /var/www/html/config.php
  fi
}

if  [ "$(ls -A /var/www/html)" == "" ]; then
  echo -e "The directory /var/www/html is empty, copying default install..."
  cp -rp /infinitewp/* /var/www/html/
  chown -R www-data:www-data /var/www/html/
  # fix css links to use https
  sudo sed -i "s|http://${IWP_HOSTNAME}|https://${IWP_HOSTNAME}|g" /var/www/html/uploads/cache/*.css
  echo -e "Done."
  # install_version=$(grep \'INSTALL_APP_VERSION /var/www/html/install/installFunctions.php|cut -d',' -f2|tr -d " ');")
  # install_hash=$(sha1sum "/var/www/html/index.php")
  # add_wp_option "INSTALL_APP_VERSION" ${install_version}
  # add_wp_option "APP_INSTALL_HASH" ${install_hash}
fi


# add_wp_option "APP_DOMAIN_PATH" "${IWP_HOSTNAME}"
# add_wp_option "APP_DOMAIN_PATH_V3" "${IWP_HOSTNAME}/v3"

echo -e "Starting apache..."
/usr/local/bin/docker-php-entrypoint -DFOREGROUND
# ls -lt /tmp
while true; do sleep 15; done
