# frozen_string_literal: true

module ToyPng
  class Png
    module Chunk
      class Iend < BaseChunk
        CHUNK_TYPE = "IEND"

        def initialize()
          @chunk_length = "\x00\x00\x00\x00".b
          @chunk_type = "IEND".b
          @chunk_data = "".b
          @chunk_crc = "\xAEB`\x82".b
        end

        def self.read(chunk_byte_data, offset = 0)
          unless(self.match?(chunk_byte_data[offset, 12]))
            raise StandardError, "arg is not IEND chunk data."
          end
          self.new()
        end

        def bytes
          @chunk_length + @chunk_type + @chunk_data + @chunk_crc
        end

        def self.match?(check_byte_string)
          check_byte_string.b == "\x00\x00\x00\x00IEND\xAEB`\x82".b
        end
      end
    end
  end
end