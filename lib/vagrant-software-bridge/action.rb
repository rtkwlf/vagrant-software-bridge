module VagrantPlugins
  module SoftwareBridge
    class Action
      def initialize(app, env)
        @app = app
      end

      def call(env)
        bridges = env[:machine].config.software_bridge.software_bridges.map.with_index do |bridge, index|
          # If interface name is not specified, default to br<index>.
          normalize_config({:interface => "br#{index}"}.merge(bridge || {}))
        end

        # Call subsequent middleware steps. We'll do our setup at the
        # end
        @app.call(env)
        
        if !bridges.empty?
          env[:ui].output("Configuring software bridges...")
          env[:machine].guest.capability(:configure_software_bridges,
                                         bridges)
        end
      end

      def normalize_config(config)
        return {
          :type => "dhcp",
          :auto_config => true,
          :bridge_ports => [],
          :ip => nil,
          :netmask => "255.255.255.0"
        }.merge(config || {})
      end
    end
  end
end
