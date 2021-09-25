# frozen_string_literal: true
require_relative "./file_structure"
require_relative "./chunk"

module ToyPng
  class Png
    class Parser
      class << self
        def parse(file)
          @@file = file.read.b

          @@pos = 0
          unless(is_png())
            raise StandardError, "#{@@file} is not png file."
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
            iend,
          ]
        end

        private
        def is_png()
          ToyPng::Png::FileStructure.match?(@@file[0, 8]) && ToyPng::Png::Chunk::Iend.match?(@@file[-12, 12])
        end

        def read_file_sign
          @@pos += 8
          ToyPng::Png::FileStructure.new
        end

        def read_ihdr
          chunk = ToyPng::Png::Chunk::Ihdr.read(@@file, @@pos)
          @@pos += chunk.bytes.size
          chunk
        end

        def read_chunk
          @@pos += @@file[@@pos, @@pos+4].unpack1("N") + 12
          nil
        end

        def read_iend
          chunk = ToyPng::Png::Chunk::Iend.new()
          @@pos += chunk.bytes.size
          chunk
        end

      end
    end
  end
end
