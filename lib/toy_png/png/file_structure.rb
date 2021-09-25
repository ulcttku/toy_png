# frozen_string_literal: true

module ToyPng
  class Png
    class FileStructure
      # 89 50 4E 47 0D 0A 1A 0A
      @@bytes = "\x89PNG\r\n\x1A\n".b
      class << self
        def bytes() = @@bytes
        def match?(check_byte_string)
          check_byte_string.b == @@bytes
        end
      end
    end
  end
end
