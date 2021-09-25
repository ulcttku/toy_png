# frozen_string_literal: true
require "zlib"

module ToyPng
  class Png
    module Chunk
      class BaseChunk
        CHUNK_TYPE = "" # Must set chunk_type

        # Initialize chunks by receiving numeric chunk data.
        def initialize
          raise StandardError, "Must implement."
        end

        # Read a byte string and create a chunk.
        def self.read(byte_string, offset = 0)
          raise StandardError, "Must implement."
        end

        # Convert a number to a byte string.
        def bytes
          raise StandardError, "Must implement."
        end

        protected def calc_crc(chunk_data) = self.class.calc_crc(chunk_data)

        class << self

          # Receives byte strings and splits them into parts.
          def split_parts(byte_string, offset = 0)
            pos = offset
            chunk_length = byte_string[pos, 4]
            pos += 4

            chunk_data_length = chunk_length.unpack1("N")

            read_type = byte_string[pos, 4]
            pos += 4

            if(read_type != self::CHUNK_TYPE)
              raise StandardError, "Not match chunk type."
            end
            chunk_type = read_type

            chunk_data = byte_string[pos, chunk_data_length]
            pos += chunk_data_length

            read_crc = byte_string[pos, 4]
            pos += 4

            calced_crc = calc_crc(chunk_type + chunk_data)
            if(read_crc != calced_crc)
              raise StandardError, "Not match CRC."
            end
            chunk_crc = read_crc

            {
              length: chunk_length,
              chunk_type: chunk_type,
              chunk_data: chunk_data,
              crc: chunk_crc,
            }
          end

          def calc_crc(byte_string)
            [Zlib.crc32(byte_string) & 0xFFFFFFFF].pack("N")
          end
        end
      end
    end
  end
end