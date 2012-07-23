class Prissy
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

    protected

    def print_object(object, starting_column = 0)
      if object.empty?
	print_literal '{}'
      elsif object.size == 1
	pair = object.first
	print_literal '{'
	print_pair(pair.first, pair.last)
	print_literal '}'
      else
	max_key_width = object.keys.max_by { |k| k.length }.length
	print_literal '{'
	newline!
	@indent += 1
	object.keys.sort.each do |key|
	  value = object[key]
	  indent!
	  print_pair(key, value, max_key_width)
	  print_literal ',' unless key == object.keys.sort.last
	  newline!
	end
	@indent -= 1
	indent!
	print_literal '}'
      end
    end

    def print_pair(key, value, max_key_width = 0)
      print_key(key)
      print_separator
      spacing = max_key_width > 0 ? (max_key_width - key.length) : 0
      @txt << " " * spacing
      print_value(value, @indent * 2 + key.length + 4 + spacing )
    end

    def print_array(array, starting_column = 0)
      # Length of all values, plus quotes, commas, spaces and brackets
      array_length = calculate_array_length(array)

      if !array.any?{|el| el.is_a?(Hash) || el.is_a?(Array)} &&
	(starting_column + array_length < options[:max_width])

	print_literal '['
	array.each do |el|
	  print_value(el)
	  print_literal ', ' unless el == array.last
	end
	print_literal ']'
      else
	print_literal '['
	newline!
	@indent += 1
	array.each do |el|
	  indent!
	  print_value(el)
	  print_literal ',' unless el == array.last
	  newline!
	end
	@indent -= 1
	indent!
	print_literal ']'
      end

    end

    def print_key(key)
      @txt << MultiJson.encode(key)
    end

    def print_value(value, starting_column = 0)
      case value
      when Array      then print_array(value, starting_column)
      when Hash       then print_object(value, starting_column)
      when Numeric    then print_number(value)
      when String     then print_string(value, starting_column)
      when TrueClass  then print_true
      when FalseClass then print_false
      when NilClass   then print_null
      end
    end

    # Make all these explicit, so its easier to override them in subclasses
    def print_string(string, starting_column = 0)
      @txt << MultiJson.encode(string)
    end

    def print_number(number)
      @txt << MultiJson.encode(number)
    end

    def print_true
      @txt << "true"
    end

    def print_false
      @txt << "false"
    end

    def print_null
      @txt << "null"
    end

    def print_separator
      @txt << ": "
    end

    def print_literal(literal)
      @txt << literal
    end

    def indent!
      @txt << "  " * @indent
    end

    def newline!
      @txt << "\n"
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
