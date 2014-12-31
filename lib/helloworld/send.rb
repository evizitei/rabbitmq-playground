#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

rmq_connection = Bunny.new
rmq_connection.start

channel = rmq_connection.create_channel
queue = channel.queue("hello")
channel.default_exchange.publish("Hello World!", routing_key: queue.name)
puts "[x] Sent 'Hello World!'"

rmq_connection.close
