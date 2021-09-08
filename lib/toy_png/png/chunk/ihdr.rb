# frozen_string_literal: true
require_relative "./base_chunk"

module ToyPng
  module Png
    module Chunk
      class Ihdr < BaseChunk
        def width = byte_to_num(@chunk_data[0, 4])
        def height = byte_to_num(@chunk_data[4, 4])
        def bit_depth = byte_to_num(@chunk_data[8, 1])
        def color_type = byte_to_num(@chunk_data[9, 1])
        def compression_method = byte_to_num(@chunk_data[10, 1])
        def filter_method = byte_to_num(@chunk_data[11, 1])
        def interlace_method = byte_to_num(@chunk_data[12, 1])
      end
    end
  end
end