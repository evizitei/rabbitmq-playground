#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

rmq_connection = Bunny.new
rmq_connection.start
channel = rmq_connection.create_channel
queue = channel.queue("hello")
puts "going into listening loop, CTRL+C to quit"

queue.subscribe(block: true) do |delivery_info, properties, body|
  puts " [x] Received -> #{body}"
end
