require "prissy/version"

require 'multi_json'

class Prissy
  # Your code goes here...

  def prissy(json_or_hash)
    hash = (json_or_hash.is_a?(String) ? parse(json_or_hash) : json_or_hash)

    obj = Obj.new(hash)
    obj.to_string
  end

  protected

  def parse(json)
    MultiJson.decode(json)
  end

  class Obj

    def initialize(object, options = {})
      @object = object

    end

    def to_string
      case @object
      when String, Numeric
	encode(@object)
      when Array
	%{[#{@object.map{|o| Obj.new(o)}.join(", ")}]}
      end
    end
    alias to_s to_string # so string interp works without have to #to_string all the time

    protected

    def indent
      " " * (@depth * 2)
    end

    def pad_key(key)
      l = @key_width - key.length
      %{"#{key}#{" " * l}":}
    end

    def encode(thing)
      MultiJson.encode(thing)
    end
  end
end

def Prissy(json_or_hash)
  Prissy.new.prissy(json_or_hash)
end
