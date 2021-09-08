# frozen_string_literal: true
require "zlib"

module ToyPng
  module Png
    module Chunk
      class BaseChunk
        attr_reader :chunk_length, :chunk_type, :chunk_data, :chunk_crc
        
        def initialize(chunk_byte_data)
          @chunk_length = chunk_byte_data[0, 4]
          @chunk_type = chunk_byte_data[4, 4]
          @chunk_data = chunk_byte_data[8, chunk_data_length()]

          read_crc = chunk_byte_data[8 + chunk_data_length(), 4]
          calced_crc = update_crc()

          if(read_crc != calced_crc)
            raise StandardError.new("Message")
          end
          @chunk_crc = calced_crc
        end

        def full_length
          (@chunk_length + @chunk_type + @chunk_data + @chunk_crc).length
        end

        private

        def update_crc()
          crc = Zlib.crc32(@chunk_type + @chunk_data) & 0xFFFFFFFF
          24.step(0, -8).map {(crc & (0xFF << _1)) >> _1}.pack("C*")
        end

        def chunk_data_length
          byte_to_num(@chunk_length)
        end

        protected

        def byte_to_num(byte_string)
          byte_string.split("").map.with_index {|b,i| b.ord<<(4*(3-i))}.sum
        end
      end
    end
  end
end