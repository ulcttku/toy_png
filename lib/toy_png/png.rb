# frozen_string_literal: true
require_relative "./png/parser"
require_relative "./png/writer"

module ToyPng
  class Png
    def self.read(file_name)
      file = File.open(file_name, "rb").read
      ToyPng::Png::Parser.parse(file)
    end

    attr_accessor(
      :ihdr, :plte, :idat, :iend,
      :bKgd, :chrm, :gama, :hist, :phys, :sbit, :text, :time, :trns
    )

    def initialize(
      width: 0,
      height: 0,
      bit_depth: 8,
      color_type: 6,
      compression_method: 0,
      filter_method: 0,
      interlace_method: 0
    )
      @ihdr = ToyPng::Png::Chunk::Ihdr.create(
        width,
        height,
        bit_depth,
        color_type,
        compression_method,
        filter_method,
        interlace_method
      )
      @iend = ToyPng::Png::Chunk::Iend.create()
    end

    def set_pixels(pixels)
      @idat = [ToyPng::Png::Chunk::Idat.create(pixels)]
    end

    def save(file_name)
      ToyPng::Png::Writer.write(self, file_name)
    end
  end
end
