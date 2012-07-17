require "prissy/version"
require 'prissy/printer'

require 'multi_json'


class Prissy
  attr_reader :options

  def initialize(options = {})
    defaults = {
      :printer => :plain
    }

    @options = defaults.merge(options)
  end

  def prissy(json_or_hash)
    hash = (json_or_hash.is_a?(String) ? parse(json_or_hash) : json_or_hash)

    printer = Printer.new
    printer.print(hash)
  end

  protected

  def parse(json)
    MultiJson.decode(json)
  end


end

def Prissy(json_or_hash)
  Prissy.new.prissy(json_or_hash)
end
