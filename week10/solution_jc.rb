def 💩
  qwerty_to_dvorak = {
    a: "a",
    b: "x",
    c: "j",
    d: "e",
    e: ".",
    f: "u",
    g: "i",
    h: "d",
    i: "c",
    j: "h",
    k: "t",
    l: "n",
    m: "m",
    n: "b",
    o: "r",
    p: "l",
    q: "'",
    r: "p",
    s: "o",
    t: "y",
    u: "g",
    v: "k",
    w: ",",
    x: "q",
    y: "f",
    z: ";"
  }

  # These characters map to punctuation marks
  ignored_chars = ["q", "w", "e", "z"]
  word_mapping = {}

  words = File.read('/usr/share/dict/words').downcase
  output_file = File.new('output.txt', 'w+')
  output_string = ""

  words.each_line do |word|
    stripped = word.strip
    characters = stripped.chars

    # Ignore any word whose dvorak equivalent contains a punctuation mark
    next if characters.any?{|c| ignored_chars.include?(c)}

    dvorak = ''
    characters.each{|c| dvorak += qwerty_to_dvorak[c.to_sym]}
    word_mapping[stripped] = dvorak
  end

  word_mapping.each do |word, dvorak|
    characters = word.chars
    next if characters.any?{|c| ignored_chars.include?(c)}

    output_string += "q:#{word}|d:#{dvorak}\n" if !word_mapping[word_mapping[word]].nil?
  end

  output_file.puts(output_string)
  output_file.close
end

💩
