# -*- mode: ruby -*-
# vi: set ft=ruby :

# Install vagrant-list for the ability to list running vagrant boxes
# https://github.com/joshmcarthur/vagrant-list
# vagrant plugin install vagrant-list

# Install vagrant-hostsupdater to automatically add hosts entries
# https://github.com/cogitatio/vagrant-hostsupdater
# vagrant plugin install vagrant-hostsupdater

Vagrant::configure("2") do |config|
  config.vm.box = "learnway/debian-squeeze"
  config.vm.box_url = "learnway/debian-squeeze"

  load File.expand_path("./user/directories.pp")
  config.vm.synced_folder $projects, "/srv/www/", :nfs => true
  config.vm.synced_folder "./configuration/", "/configuration/", :nfs => true

  config.vm.network :private_network,
    ip: "192.168.50.4"
  config.vm.network "forwarded_port", guest: 80, host: 5009
  config.vm.network "forwarded_port", guest: 443, host: 5010

  config.vm.hostname = "www.bpb-vagrant.dev"

  load File.expand_path("../user/vhosts.pp", __FILE__)
  config.hostsupdater.aliases = $vhosts.keys
  config.hostsupdater.remove_on_suspend = true

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize [
      "modifyvm", :id,
      # "--memory", "1024",
      "--memory", "256",
      "--name", "bpb-php-53",
      "--natdnshostresolver1", "on"
    ]
  end

  # Prepare facts
  $facts = "export FACTER_vagrant_apache_vhosts=\""
  $vhosts.each do |name, directory|
    $facts += name + "," + directory + " "
  end
  $facts += "\";\n"

  load File.expand_path("../user/dbs.pp", __FILE__)
  $facts += "export FACTER_dbs=\""
  $dbs.each do |name, username_password|
    $facts += name + "," + username_password + " "
  end
  $facts += "\";\n"

  $bootstrap = File.read("./shell/bootstrap.sh")

  config.vm.provision :shell, :inline => $facts + $bootstrap;
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.synced_folder "/var/www", "/var/www", create:true, type: "nfs"
end

