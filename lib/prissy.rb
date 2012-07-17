require "prissy/version"
require 'prissy/printer'
require 'prissy/color_printer'

require 'multi_json'


class Prissy
  attr_reader :options

  def initialize(options = {})
    defaults = {}

    @options = defaults.merge(options)
  end

  def prissy(json_or_hash)
    hash = (json_or_hash.is_a?(String) ? parse(json_or_hash) : json_or_hash)

    printer.print(hash)
  end

  protected

  def parse(json)
    MultiJson.decode(json)
  end

  def printer
    @printer ||= begin
      if $0 =~ /prissy$/
	if options[:color]
	  ColorPrinter.new(options)
	else
	  Printer.new(options)
	end
      else
	Printer.new(options)
      end
		 end
  end


end

def Prissy(json_or_hash)
  Prissy.new.prissy(json_or_hash)
end
