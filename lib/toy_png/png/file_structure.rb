# frozen_string_literal: true

module ToyPng
  module Png
    class FileStructure
      # 89 50 4E 47 0D 0A 1A 0A
      @@data = "\x89PNG\r\n\x1A\n"
      class << self
        def match?(byte_string)
          byte_string[0, 8].bytes == @@data.bytes
        end
      end
    end
  end
end
