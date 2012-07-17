require "prissy/version"

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

  class Printer
    attr_reader :options

    def initialize(options = {})
      @txt = ""
      @indent = 0
      @options = options
      options[:max_width] ||= 80
    end

    def print(object)
      print_object(object)
      @txt << "\n"
    end

    def print_object(object)
      if object.empty?
	@txt << '{}'
      elsif object.size == 1
	pair = object.first
	@txt << "{"
	print_pair(pair.first, pair.last)
	@txt << "}"
      else
	max_key_width = object.keys.max_by { |k| k.length }.length
	@txt << "{\n"
	@indent += 1
	object.keys.sort.each do |key|
	  value = object[key]
	  indent
	  print_pair(key, value, max_key_width)
	  @txt << "," unless key == object.keys.sort.last
	  @txt << "\n"
	end
	@indent -= 1
	indent
	@txt << '}'
      end
    end

    def print_pair(key, value, max_key_width = 0)
      separator = ":"
      print_key(key)
      @txt << ": "
      @txt << " " * (max_key_width - key.length) if max_key_width > 0
      print_value(value)
    end

    def print_array(array)
      # Length of all values, plus quotes, commas, spaces and brackets
      array_length = calculate_array_length(array)

      if !array.any?{|el| el.is_a?(Hash) || el.is_a?(Array)} &&
	(@indent * 2 + array_length < options[:max_width])

	@txt << "["
	array.each do |el|
	  print_value(el)
	  @txt << ", " unless el == array.last
	end
	@txt << "]"
      else
	@txt << "[\n"
	@indent += 1
	array.each do |el|
	  indent
	  print_value(el)
	  @txt << "," unless el == array.last
	  @txt << "\n"
	end
	@indent -= 1
	indent
	@txt << "]"
      end

    end

    def print_key(key)
      @txt << %{"#{key.to_s}"}
    end

    def print_value(value)
      case value
      when String, Numeric, TrueClass, FalseClass
	@txt << value.inspect
      when Hash
	print_object(value)
      when Array
	print_array(value)
      when NilClass
	@txt << "null"
      end
    end

    def indent
      @txt << "  " * @indent
    end

    def calculate_array_length(array)
      array.inject(0) do |sum, item|
	case item
	when Numeric, TrueClass, FalseClass, NilClass
	  sum += item.to_s.length
	when String
	  sum += item.length + 2 # "quotes"
	end
	sum += 2 # ", "
      end
    end
  end

end

def Prissy(json_or_hash)
  Prissy.new.prissy(json_or_hash)
end
