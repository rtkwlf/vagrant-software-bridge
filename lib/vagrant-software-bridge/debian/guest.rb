require "vagrant"

module VagrantPlugins
  module GuestDebian
    class Plugin < Vagrant.plugin("2")
      guest_capability("debian", "configure_software_bridges") do
        require_relative "configure_software_bridges"
        Cap::ConfigureSoftwareBridges
      end
    end
  end
end
