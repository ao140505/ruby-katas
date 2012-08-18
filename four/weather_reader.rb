class WeatherReader
  class << self

    def read(file)
      begin
        day, min = nil, nil

        File.open(file).each_line do |line|
          if line =~ /^\s*\d+/
            columns = line.split
            spread = columns[1].to_i - columns[2].to_i

            if min.nil? || spread < min
              min = spread
              day = columns[0]
            end
          end
        end
        puts "day: #{day}, min: #{min}"
      rescue => e
        puts "#{e.class} - #{e}"
      end
    end

  end
end

WeatherReader.read('weather.dat')
