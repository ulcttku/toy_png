# frozen_string_literal: true
require_relative "./base_chunk"
require 'zlib'

module ToyPng
  class Png
    module Chunk
      class Idat < BaseChunk
        def self.create(pixels)
          pixels_data = pixels
            .map{ [[0]].concat(_1) }
            .flatten()
            .pack("C*")

          chunk_data =  self.to_s.split("::").last.upcase +
            self.deflate(pixels_data)

          chunk_byte_data = [chunk_data.length - 4].pack("N") +
            chunk_data +
            calc_crc(chunk_data)

          read(chunk_byte_data)
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