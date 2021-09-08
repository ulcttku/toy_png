# frozen_string_literal: true
require_relative "./file_structure"
require_relative "./chunk"

module ToyPng
  module Png
    class Parser
      class << self
        def parse(file)
          @@file = file

          @@pos = 0
          unless(is_png(file))
            raise StandardError.new("")
          end

          file_sign = read_file_sign()
          ihdr = read_ihdr()
          chunk1 = read_chunk()
          chunk2 = read_chunk()
          chunk3 = read_chunk()
          iend = read_iend()

          [
            file_sign,
            ihdr,
            chunk1,
            chunk2,
            chunk3,
            iend,
          ]
        end

        private
        def is_png(file)
          ToyPng::Png::FileStructure.match?(file) && ToyPng::Png::Chunk::Iend.match?(file)
        end

        def read_file_sign
          @@pos += 8
          ToyPng::Png::FileStructure.new
        end

        def read_ihdr
          chunk = ToyPng::Png::Chunk::Ihdr.new(@@file[@@pos..-1])
          @@pos += chunk.full_length
          chunk
        end

        def read_chunk
          chunk = ToyPng::Png::Chunk::BaseChunk.new(@@file[@@pos..-1])
          @@pos += chunk.full_length
          chunk
        end

        def read_iend
          chunk = ToyPng::Png::Chunk::Iend.new()
          @@pos += chunk.full_length
          chunk
        end

      end
    end
  end
end
