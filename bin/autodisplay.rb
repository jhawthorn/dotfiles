#!/usr/bin/env ruby


class Displays < Struct.new(:name, :description, :resolutions)
  def self.parse string
    ret = []
    string.scan /display ([a-z0-9-]+): ([^\n]*\n) resolutions: ([0-9x, ]+)/im do
      ret << new($1, $2, $3.split(', '))
    end
    ret
  end
  def self.all
    parse(`disper -l`)
  end
end

all = Displays.all

names = all.map(&:name)

puts names.inspect

if names.count > 1
  ## Use all but builtin LCD
  #names.delete('DFP-0')
end

cmd = "disper -d '#{names.join(',')}' -e"
`#{cmd}`

