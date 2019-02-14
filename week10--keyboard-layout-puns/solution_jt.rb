class Dvorak
  def initialize
    @querty_to_dvorak = { a: "a",b: "x",c: "j",d: "e",e: ".",f: "u",g: "i",h: "d",i: "c",j: "h",k: "t",l: "n",m: "m",n: "b",o: "r",p: "l",q: "'",r: "p",s: "o",t: "y",u: "g",v: "k",w: ",",x: "q",y: "f",z: ";" }
  end

  def to_dvorak word
    dvorak_word = ""
    word.split('').each do |character|
      dvorak_character = @querty_to_dvorak[character.to_sym]
      dvorak_word += dvorak_character if dvorak_character
    end

    dvorak_word
  end

end

words = Hash.new
File.open("/usr/share/dict/words") do |file|
  file.each do |line|
    words[line.strip.downcase] = true
  end
end

dvorak = Dvorak.new
File.open('results.txt', 'w') do |file|
  words.keys.each do |word|
    dvorak_word = dvorak.to_dvorak(word)
    if words[dvorak_word] && words[word]
      file.puts "q:#{word}|d:#{dvorak_word}"
    end
  end
end
