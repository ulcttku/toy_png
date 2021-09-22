# frozen_string_literal: true

module ToyPng
  class Png
    class FileStructure
      # 89 50 4E 47 0D 0A 1A 0A
      @@byte_string = "\x89PNG\r\n\x1A\n".b
      class << self
        def byte_string() = @@byte_string
        def match?(check_byte_string)
          check_byte_string[0, 8].b == byte_string
        end
      end
    end
  end
end
