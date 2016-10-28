#!/usr/bin/env ruby

#
# Averages 940ms
#

require 'set'

q_to_d = {
  'a' => 'a', 'b' => 'x', 'c' => 'j', 'd' => 'e',
  'f' => 'u', 'g' => 'i', 'h' => 'd', 'i' => 'c',
  'j' => 'h', 'k' => 't', 'l' => 'n', 'm' => 'm',
  'n' => 'b', 'o' => 'r', 'p' => 'l', 'r' => 'p',
  's' => 'o', 't' => 'y', 'u' => 'g', 'v' => 'k',
  'x' => 'q', 'y' => 'f'
}

words = File.read('/usr/share/dict/words').split("\n").map(&:downcase).uniq
index = Set.new(words)
words.reject { |word| word =~ /[qwez]/ }.each do |word|
  converted = word.chars.map { |c| q_to_d[c] }.join.strip
  puts "q:#{word}|d:#{converted}" if index.member?(converted)
end
