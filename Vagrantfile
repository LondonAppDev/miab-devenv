
# Wrapper for the vagrant config.
Vagrant.configure(2) do |config|

  # Tell vagrant we want an Ubuntu Trusty64 server.
  config.vm.box = "ubuntu/trusty64"

  # Map our "salt" directory in this project to "/srv/salt" on the
  # server
  config.vm.synced_folder "salt", "/srv/salt"
  # Map our "project" directory in this project to "/project"
  config.vm.synced_folder "salt", "/srv/salt"

  # Create a public network so we can access the server from other devices
  # on our network.
  config.vm.network "public_network", type: "dhcp"

  # Configure our server to use "Salt"
  config.vm.provision :salt do |salt|

      # Run salt independently without requring a central management
      # "master" server.
      salt.masterless = true

      # Tell it to use our minion config file "minion".
      salt.minion_config = "minion"

      # After the server boots, run the salt states to defined in the
      # "salt" directory.
      salt.run_highstate = true

  end # End of Salt config.

end # End of Vagrant config.
