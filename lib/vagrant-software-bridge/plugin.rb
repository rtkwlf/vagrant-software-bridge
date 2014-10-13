require "vagrant"

require_relative "debian/guest"

module VagrantPlugins
  module SoftwareBridge
    class Plugin < Vagrant.plugin("2")
      name "Software bridge configuration"
      description "Configure software bridges to bridge physical interfaces within the VM"

      action_hook(:configure_software_bridges) do |hook|
        require_relative "action"
        # We're injecting ourselves before the Vagrant standard network
        # configuration step because we (as well as the standard network
        # configuration middleware) do the actual network configuration on the
        # way up the middleware stack. Therefore, this ensures that we will
        # configure the bridges after the rest of the interfaces.
        hook.before(VagrantPlugins::ProviderVirtualBox::Action::Network,
                    Action)
      end

      config "software_bridge" do
        require_relative "config"
        VagrantPlugins::SoftwareBridge::Config
      end
    end
  end
end
