require 'term/ansicolor'

class Prissy
  class ColorPrinter < Printer
    include Term::ANSIColor

    def print_string(string)
      super blue{string}
    end

    def print_number(number)
      super yellow{number.to_s}
    end

    def print_literal(char)
      super green{char}
    end

    def print_key(key)
      super cyan{key}
    end

    def print_true
      @txt << green{"true"}
    end
    def print_false
      @txt << green{"false"}
    end
    def print_null
      @txt << green{"null"}
    end
  end
end

