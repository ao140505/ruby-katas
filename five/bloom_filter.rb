require 'digest/md5'
require 'pry'
require 'murmurhash3'
require 'fnv'

# Given:
# a % n
# a needs to be bigger than n!!!
# else, you always get a

$bloom = []

File.open('/usr/share/dict/words','r').each_with_index do |word, i|
  if i % 12 == 0
    word.strip!
    hex = Digest::MD5.hexdigest(word)
    bits = hex.unpack('B*')[0].split('').map {|b| b.to_i}

    binding.pry
    #print '.' if i % 3000 == 0

    if $bloom.length < 1
      # starting the bloom filter
      $bloom = bits
    else
      # loop through bits and flip correct ones in bloom
      bits.each_with_index do |c, index|
        if c == 1 && $bloom[index] != 1
          $bloom[index] = 1
        end
      end
    end
  end
end

# does not work at the moment
def test_word(word)
  hex = Digest::MD5.hexdigest(word)
  bits = hex.unpack('B*')[0].split('').map {|b| b.to_i}

  bits.each_with_index do |b, index|
    if b == 1 && $bloom[index] == 0
      return 'incorrect word'
    end
  end
  return 'sucess!'
end

#binding.pry

#puts bloom.class
#puts bloom.length
#
# number of zeros in filter
puts $bloom.select { |i| i.to_i == 0}.count

#http://blog.bigbinary.com/2011/07/20/ruby-pack-unpack.html
