require 'pry'

class FootballReader
  class << self

    def read(file)
      begin
        team, min = nil, nil

        File.open(file).each_line do |line|
          if line =~ /^\s*\d+/
            columns = line.split
            spread = (columns[6].to_i - columns[8].to_i).abs

            if min.nil? || spread < min
              min = spread
              team = columns[1]
            end
          end
        end

        puts "team: #{team}, min: #{min}"

      rescue => e
        puts "#{e.class} - #{e}"
      end
    end

  end
end

FootballReader.read('football.dat')
