# frozen_string_literal: true

RSpec.describe 'ToyPng::Png::Parser' do
  it 'can parse' do
    file = File.open("./spec/fixtures/white_10x10.png", "rb").read
    chunks = ToyPng::Png::Parser.parse(file)
    expect(chunks[1].chunk_type).to eq "IHDR"
    expect(chunks[2].chunk_type).to eq "sRGB"
    expect(chunks[3].chunk_type).to eq "gAMA"
    expect(chunks[4].chunk_type).to eq "pHYs"
    expect(chunks[5].chunk_type).to eq "IEND"
  end
end