require "vagrant"

module VagrantPlugins
  module SoftwareBridge
    class Config < Vagrant.plugin(2, :config)
      def initialize
        @__software_bridges = []
      end

      def add(**options)
        @__software_bridges << options.dup
      end

      def software_bridges
        @__software_bridges
      end

      def merge(other)
        super.tap do |result|
          result.instance_variable_set(:@__software_bridges, @__software_bridges + other.software_bridges)
        end
      end
    end
  end
end
