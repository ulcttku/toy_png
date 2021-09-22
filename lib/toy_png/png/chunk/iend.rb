# frozen_string_literal: true

module ToyPng
  class Png
    module Chunk
      class Iend < BaseChunk

        def initialize()
          @chunk_length = "\x00\x00\x00\x00".b
          @chunk_type = "IEND".b
          @chunk_data = "".b
          @chunk_crc = "\xAEB`\x82".b
        end

        class << self
          def create() = self.new()

          def read(chunk_byte_data)
            unless(self.match?(chunk_byte_data))
              raise StandardError, "arg is not IEND chunk data."
            end
            self.new()
          end

          def match?(check_byte_string)
            check_byte_string[-12, 12].b == "\x00\x00\x00\x00IEND\xAEB`\x82".b
          end
        end
      end
    end
  end
end