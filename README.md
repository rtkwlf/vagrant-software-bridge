# Vagrant Software Bridge Plugin

A plugin to configure a software bridge within a guest. This may be useful when
simulating non-trivial network topologies with Vagrant guests, e.g., bridging
VirtualBox internal networks.

The implementation relies on Vagrant's guest capabilities. Currently, the plugin
supports only Debian-derived guests and in particular has been tested only on
Ubuntu. However, contributions to add support for other guests are more than
welcome.

## Installation

Use `vagrant plugin install`:

    $ vagrant plugin install vagrant-software-bridge

## Usage

Setting up a software bridge is accomplished using the `config.software_bridge.add`
gestures. The gesture takes similar parameters to `config.vm.network`, with
some exceptions. Valid parameters are as follows:

* `interface`
  The name of the bridge interface. The default is `br0`, `br1`, etc., with the
  counter being incremented with every bridge added.
* `bridge_ports`
  An array of ports (or interfaces) to add to the bridge. The interfaces must
  already exist.
* `type`
  Method of IP assignment. Valid values are "dhcp" and "static".
* `ip`
  Required if `type` is "static". The IP address to be assigned to the bridge.
* `netmask`
  Required if `type` is "static". The netmask to use for the bridge.

Note that the bridge plugin runs immediately after Vagrant network configuration,
so `bridge_ports` can include interfaces configured using `config.vm.network`.

### Example

Create a bridge that includes the interfaces `eth0` and `eth1`, and assign it
the static IP 10.0.1.2/24. Assuming this is the first bridge to be added, its
name will be `br0`.

```ruby
config.software_bridge.add bridge_ports: ["eth0", "eth1"], type: static,
                           ip: "10.0.1.2", netmask: "255.255.255.0"
```

The `config` object in the example is what was passed by Vagrant to the
`config.vm.define` block.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
