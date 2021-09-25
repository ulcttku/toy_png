# frozen_string_literal: true

RSpec.describe 'ToyPng::Png::Parser' do
  it 'can parse' do
    file = File.open("./spec/fixtures/white_10x10.png", "rb")
    chunks = ToyPng::Png::Parser.parse(file)
    expect(chunks[1].width).to eq 10
    expect(chunks[1].height).to eq 10
    expect(chunks[1].bit_depth).to eq 8
    expect(chunks[1].color_type).to eq 2
    expect(chunks[1].compression_method).to eq 0
    expect(chunks[1].filter_method).to eq 0
    expect(chunks[1].interlace_method).to eq 0
  end
end