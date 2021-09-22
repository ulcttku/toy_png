# frozen_string_literal: true
require_relative "./base_chunk"

module ToyPng
  class Png
    module Chunk
      class Ihdr < BaseChunk
        def self.create(
            width,
            height,
            bit_depth,
            color_type,
            compression_method,
            filter_method,
            interlace_method
          )
          chunk_data = self.to_s.split("::").last.upcase +
            [
              width,
              height,
              bit_depth,
              color_type,
              compression_method,
              filter_method,
              interlace_method,
            ].pack("NNC*")

          chunk_byte_data = [chunk_data.length - 4].pack("N") +
            chunk_data +
            calc_crc(chunk_data)

          read(chunk_byte_data)
        end

        def width() = @chunk_data[0, 4].unpack("N").first
        def height() = @chunk_data[4, 4].unpack("N").first
        def bit_depth() = @chunk_data[8, 1].unpack("C").first
        def color_type() = @chunk_data[9, 1].unpack("C").first
        def compression_method() = @chunk_data[10, 1].unpack("C").first
        def filter_method() = @chunk_data[11, 1].unpack("C").first
        def interlace_method() = @chunk_data[12, 1].unpack("C").first
      end
    end
  end
end