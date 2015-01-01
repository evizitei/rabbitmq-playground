#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

rmq_connection = Bunny.new
rmq_connection.start
channel = rmq_connection.create_channel
queue = channel.queue("hello")
message = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

queue.publish(message, persistent: true)
puts "[x] Sent '#{message}'"

rmq_connection.close
