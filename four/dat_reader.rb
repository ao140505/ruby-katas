require 'pry'

class DatReader
  class << self

    def read(file, opts = {})
      unless [:label, :min, :max].all? { |k| opts.key? k }
        raise 'incorrect number of options. you need to pass in columns for the label, min, and max'
      end

      begin
        label, min = nil, nil
        min_col, max_col = opts[:min], opts[:max]

        File.open(file).each_line do |line|
          if line =~ /^\s*\d+/
            columns = line.split
            spread = (columns[max_col].to_i - columns[min_col].to_i).abs

            if min.nil? || spread < min
              min = spread
              label = columns[opts[:label]]
            end
          end
        end

        puts "#{label}, min: #{min}"

      rescue Errno::ENOENT => e
        puts e
      end
    end

  end
end

DatReader.read('football.dat', label: 1, min: 8, max:6)
DatReader.read('weather.dat', label: 0, min: 2, max:1)
