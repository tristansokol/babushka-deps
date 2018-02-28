dep 'php' do
  met? { log_shell "checking if php is installed",'which php' }
end

dep 'composer' do
  require 'php'
  met? { log_shell "checking if composer is installed",'which composer' }
  meet do
    log 'installing composer'
    shell "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    shell "php -r \"if (hash_file('SHA384', 'composer-setup.php') === '$(curl -Ss https://composer.github.io/installer.sig)') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;\""
    shell "php composer-setup.php
    php -r \"unlink('composer-setup.php');\""
    shell "mv composer.phar /usr/local/bin/composer"
  end
end
