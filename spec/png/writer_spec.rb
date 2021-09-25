# frozen_string_literal: true
require "stringio"

RSpec.describe 'ToyPng::Png::Writer' do
  it 'can create png file' do
    png = ToyPng::Png.new(width: 10, height: 10, color_type: 2)
    png.set_pixels([[[0, 255, 0]] * 10] * 10)

    file = StringIO.new(+"", 'w+')
    allow(File).to receive(:open).and_yield(file)

    ToyPng::Png::Writer.write(png, "dummy_filename")

    file.rewind
    expect(ToyPng::Png::FileStructure.match?(file.read[0, 8])).to eq true

    file.rewind
    expect(ToyPng::Png::Chunk::Iend.match?(file.read[-12, 12])).to eq true
  end

  it 'cannot create png file if IHDR does not exist.' do
    png = ToyPng::Png.new(width: 10, height: 10, color_type: 2)
    png.ihdr = nil
    png.set_pixels([[[0, 255, 0]] * 10] * 10)

    file = StringIO.new(+"", 'w+')
    allow(File).to receive(:open).and_yield(file)

    expect {
      ToyPng::Png::Writer.write(png, "dummy_filename")
    }.to raise_error("IHDR is not found.")
  end

  xit 'cannot create png file if color type is 3 and PLTE does not exist.' do
    # not implemented.
  end

  it 'cannot create png file if IDAT does not exist.' do
    png = ToyPng::Png.new(width: 10, height: 10, color_type: 2)

    file = StringIO.new(+"", 'w+')
    allow(File).to receive(:open).and_yield(file)

    expect {
      ToyPng::Png::Writer.write(png, "dummy_filename")
    }.to raise_error("IDAT is not found.")
  end

  it 'cannot create png file if IEND does not exist.' do
    png = ToyPng::Png.new(width: 10, height: 10, color_type: 2)
    png.set_pixels([[[0, 255, 0]] * 10] * 10)
    png.iend = nil

    file = StringIO.new(+"", 'w+')
    allow(File).to receive(:open).and_yield(file)

    expect {
      ToyPng::Png::Writer.write(png, "dummy_filename")
    }.to raise_error("IEND is not found.")
  end


end