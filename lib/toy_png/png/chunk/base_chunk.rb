# frozen_string_literal: true
require "zlib"

module ToyPng
  class Png
    module Chunk
      class BaseChunk
        attr_reader :chunk_length, :chunk_type, :chunk_data, :chunk_crc

        def initialize(chunk_byte_data)
          @chunk_length = chunk_byte_data[0, 4]
          @chunk_type = chunk_byte_data[4, 4]
          @chunk_data = chunk_byte_data[8, chunk_data_length()]

          read_crc = chunk_byte_data[8 + chunk_data_length(), 4]
          calced_crc = calc_crc(@chunk_type + @chunk_data)

          if(read_crc != calced_crc)
            raise StandardError, "Not match CRC."
          end
          @chunk_crc = calced_crc
        end

        def self.create
          raise StandardError, "Must implement."
        end

        def self.read(chunk_byte_data)
          self.new(chunk_byte_data)
        end

        def byte_string
          @chunk_length + @chunk_type + @chunk_data + @chunk_crc
        end

        def full_length
          byte_string.length
        end

        protected

        def chunk_data_length
          @chunk_length.unpack("N").first
        end

        def calc_crc(chunk_data) = self.class.calc_crc(chunk_data)

        def self.calc_crc(chunk_data)
          crc = Zlib.crc32(chunk_data) & 0xFFFFFFFF
          24.step(0, -8).map {(crc & (0xFF << _1)) >> _1}.pack("C*")
        end
      end
    end
  end
end