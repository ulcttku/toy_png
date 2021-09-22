# frozen_string_literal: true
require_relative "./file_structure"

module ToyPng
  class Png
    class Writer
      class << self
        def write(png, file_name)
          if(png.ihdr == nil)
            raise StandardError, "IHDR is not found."
          end

          if(png.ihdr.color_type == 3 &&  png.plte == nil)
            raise StandardError, "color type is 3 and PLTE is not found."
          end

          if(png.idat == nil || png.idat.length == 0)
            raise StandardError, "IDAT is not found."
          end

          if(png.iend == nil)
            raise StandardError, "IEND is not found."
          end

          png_file_name = if(file_name.match?(/.+?\.png/))
            File.expand_path(file_name, File.dirname(__dir__))
          else
            File.expand_path(file_name + ".png", File.dirname(__dir__))
          end

          if(File.exist?(png_file_name))
            raise StandardError, "#{png_file_name} is exist."
          end

          File.open(png_file_name, "wb") do |f|
            f.write ToyPng::Png::FileStructure.byte_string
            f.write png.ihdr.byte_string
            png.idat.each do |data|
              f.write data.byte_string
            end
            f.write png.iend.byte_string
          end
        end
      end
    end
  end
end
