require "vagrant-software-bridge/plugin"
require "pathname"

module VagrantPlugins
  module SoftwareBridge
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
    end
  end
end
