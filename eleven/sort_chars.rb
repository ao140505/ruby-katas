# start with something like this...
"it's a Test".downcase.gsub(/[^a-z]+/, '')

# final answer should do this
"it'''!s a Te,.st".downcase.gsub(/[^a-z]+/, '').chars.sort.join
