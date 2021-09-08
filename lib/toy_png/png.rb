# frozen_string_literal: true
require_relative "./png/parser"

module ToyPng
  module Png
    def self.read(file_name)
      file = File.open(file_name, "rb").read
      ToyPng::Png::Parser.parse(file)
    end
  end
end
