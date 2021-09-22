# frozen_string_literal: true

module ToyPng
  class Png
    module Chunk
      class Iend < BaseChunk

        def initialize()
          @chunk_length = "\x00\x00\x00\x00"
          @chunk_type = "IEND"
          @chunk_data = ""
          @chunk_crc = "\xAEB`\x82"
        end

        class << self
          def create() = self.new()

          def read(chunk_byte_data)
            unless(self.match?(chunk_byte_data))
              raise StandardError, "arg is not IEND chunk data."
            end
            self.new()
          end

          def match?(byte_string)
            # The encoding of the RHS is UTF-8, and the encoding of the LHS is ASCII-8BIT.
            # Besides, the encoding of the RHS cannot be converted to ASCII-8BIT,
            # so it is compared as an array of numbers.
            byte_string[-12, 12].bytes == "\x00\x00\x00\x00IEND\xAEB`\x82".bytes
          end
        end
      end
    end
  end
end