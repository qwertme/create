#!/usr/bin/env ruby
CREATE_HOME="#{ENV['HOME']}/lib/create"
require 'erb'

if ARGV.size < 1
   puts 'Usage: create <template name> [var=value...]'
   exit(1)
end

template_name = ARGV.first
ARGV.shift

template_values = Object.new
class << template_values
   def init
      ARGV.each do |arg|
         arg_array = arg.split('=')
         eval("@#{arg_array[0]} = '#{arg_array[1]}'")
      end
   end

   def get_binding
      binding
   end
end

template_values.init

template = IO.readlines("#{CREATE_HOME}/templates/#{template_name}.erb").to_s

result = ERB.new(template)

result.run(template_values.get_binding)
