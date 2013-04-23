#require 'pry'

class Do
  def self.it
    lines = 0
    in_book = false
    relevent_lines = []

    File.open('fourteen/tom_swift.txt','r').each do |line|

      if in_book && line.present?
        lines += 1
        relevent_lines << line.gsub(/\"|,|\./, '')
      end

      if line.match /Chapter 1\r\n/
        in_book = true
      end
      if line.match /End of Project Gutenberg's Tom Swift/
        in_book = false
      end

      break if lines > 10
    end
    puts relevent_lines
  end
end

class String
  def blank?
    strip.empty?
  end

  def present?
    !blank?
  end
end

Do.it
