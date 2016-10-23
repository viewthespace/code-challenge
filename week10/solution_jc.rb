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

    output_string += "q:#{stripped}|d:#{dvorak}\n" if words.match(Regexp.new(Regexp.escape(dvorak)))
  end

  output_file.puts(output_string)
  output_file.close
end

💩
