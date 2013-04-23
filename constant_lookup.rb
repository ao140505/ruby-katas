# this illustrates how constant lookup works in ruby

# search goes in this order:
# lexical scope
# parent modules
# included modules
# ancestors

module Kernel
  A = B = C = D = E = F = 'defined in kernel'
end

A = B = C = D = E = 'defined at top level'

class Super
  A = B = C = D = 'defined in superclass'
end

module Included
  A = B = C = 'defined in included module'
end

module Enclosing
  A = B = 'defined in enclosing module'

  class Local < Super
    include Included

    A = 'defined locally'

    search = (Module.nesting + self.ancestors + Object.ancestors).uniq
    p search

    puts A
    puts B
    puts C
    puts D
    puts E
    puts F
  end
end
