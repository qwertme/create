#!/usr/bin/env ruby
CREATE_HOME="#{ENV['HOME']}/lib/create"
require 'erb'

if ARGV.size < 1
   puts 'Usage: create <template name> [var=value...]'
   exit(1)
end

template_name = ARGV.first
ARGV.shift
parameters = {}
ARGV.each do |arg|
  arg_array = arg.split('=')
  parameters[arg_array[0].to_sym] = arg_array[1]
end

class TemplateRunner
  def initialize(parameters)
    @parameters = parameters
  end

  def mandatory(name)
    unless @parameters.has_key?(name)
      puts "Missing mandatory parameter '#{name}'"
      exit 1
    end
    @parameters[name]
  end
end

template = IO.readlines("#{CREATE_HOME}/templates/#{template_name}.erb").join

result = ERB.new(template)
result.def_method(TemplateRunner, 'render')

template_values = TemplateRunner.new(parameters)
print template_values.render
