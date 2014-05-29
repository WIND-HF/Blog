#!/usr/bin/env ruby
#encoding: utf-8

require 'socket'

def public_ipv4
  Socket.ip_address_list.detect { |intf| intf.ipv4? and \
                                         not intf.ipv4_loopback? and \
                                         not intf.ipv4_multicast? and \
                                         not intf.ipv4_private? }
end

def private_ipv4
  Socket.ip_address_list.detect { |intf| intf.ipv4_private? }
end

ip = public_ipv4.ip_address unless public_ipv4.nil?
ip ||= private_ipv4.ip_address() unless private_ipv4.nil?

puts ip
