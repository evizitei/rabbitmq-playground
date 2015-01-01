#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

rmq_connection = Bunny.new
rmq_connection.start
channel = rmq_connection.create_channel
channel.prefetch(1)
queue = channel.queue("hello")
puts "going into listening loop, CTRL+C to quit"

queue.subscribe(manual_ack: true, block: true) do |delivery_info, properties, body|
  puts " [x] Received -> #{body}"

  # pretend we're doing something complicated
  # the more dots in the message, the more complicated it is
  sleep body.count(".").to_i

  puts " [x] Work complete!"
  channel.ack(delivery_info.delivery_tag)
end
