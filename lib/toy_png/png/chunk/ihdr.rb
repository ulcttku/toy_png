# frozen_string_literal: true
require_relative "./base_chunk"

module ToyPng
  class Png
    module Chunk
      class Ihdr < BaseChunk
        attr_accessor(
          :width,
          :height,
          :bit_depth,
          :color_type,
          :compression_method,
          :filter_method,
          :interlace_method,
        )
        CHUNK_TYPE = "IHDR"

        def initialize(
            width,
            height,
            bit_depth,
            color_type,
            compression_method,
            filter_method,
            interlace_method
          )
            @width = width
            @height = height
            @bit_depth = bit_depth
            @color_type = color_type
            @compression_method = compression_method
            @filter_method = filter_method
            @interlace_method = interlace_method
        end

        def self.read(byte_string, offset = 0)
          case self.split_parts(byte_string, offset)
          in {chunk_data: chunk_data}
            self.new(
              chunk_data[ 0, 4].unpack1("N"),
              chunk_data[ 4, 4].unpack1("N"),
              chunk_data[ 8, 1].unpack1("C"),
              chunk_data[ 9, 1].unpack1("C"),
              chunk_data[10, 1].unpack1("C"),
              chunk_data[11, 1].unpack1("C"),
              chunk_data[12, 1].unpack1("C"),
            )
          end
        end

        def bytes
          chunk_data = [
            @width,
            @height,
            @bit_depth,
            @color_type,
            @compression_method,
            @filter_method,
            @interlace_method,
          ].pack("NNCCCCC")

          [chunk_data.length].pack("N") +
            CHUNK_TYPE +
            chunk_data +
            calc_crc(chunk_data)
        end
      end
    end
  end
end