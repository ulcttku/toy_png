# frozen_string_literal: true
require_relative "./base_chunk"
require 'zlib'

module ToyPng
  class Png
    module Chunk
      class Idat < BaseChunk
        attr_accessor :pixels

        CHUNK_TYPE = "IDAT"

        def initialize(pixels)
          @pixels = pixels
        end

        def self.read(byte_string, offset = 0)
          # TODO: impl
        end

        def bytes
          pixels_data = @pixels
            .map{ [[0]].concat(_1) }
            .flatten()
            .pack("C*")

          chunk_data = self.class.deflate(pixels_data)

          [chunk_data.length].pack("N") +
            CHUNK_TYPE +
            chunk_data +
            calc_crc(chunk_data)
        end

        private
        def self.deflate(string, level = Zlib::BEST_COMPRESSION)
          zlib = Zlib::Deflate.new(level)
          dst = zlib.deflate(string, Zlib::FINISH)
          zlib.close
          dst
        end
      end
    end
  end
end