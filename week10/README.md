# Keyboard Layout Puns

Why do programmers always confuse Halloween and Christmas? 
**Because Oct31 = Dec25!**

If you figure out that pun, congratulations. But either way, we are going to find opportunities for puns based on typing the same keystrokes on different keyboard layouts.

The goal: **find all words whose keystrokes generate valid English words when typed on both Qwerty and Dvorak keyboard layouts.** For example:

- hot (qwerty) = dry (dvorak)

Let's take the example of typing "hot" on a qwerty keyboard. The keystroke sequence is `h -> o -> t`. Typing those same keys on a Dvorak keyboard will produce `d -> r -> y`. They're both English words, so now we can make a pun:

*In the middle of the summer, a Qwerty typist asks a Dvorak typist, "Hey is it gonna be dry tomorrow?" The Dvorak typist answers, "Yea, extremely dry." The Qwerty typist walks outside the next day and gets caught in the rain without an umbrella.*

See, a pun!

For the sake of this challenge, a "valid English word" is a word that appears in `/usr/share/dict/words`.

Here are the character mappings between the two layouts (Note that each direction is given, i.e. qwerty -> dvorak and dvorak -> qwerty. Again, direction matters!)

|qwerty|dvorak|
|---|---|
|a|a|
|b|x|
|c|j|
|d|e|
|e|.|
|f|u|
|g|i|
|h|d|
|i|c|
|j|h|
|k|t|
|l|n|
|m|m|
|n|b|
|o|r|
|p|l|
|q|'|
|r|p|
|s|o|
|t|y|
|u|g|
|v|k|
|w|,|
|x|q|
|y|f|
|z|;|

---

|dvorak|qwerty|
|---|---|
|a|a|
|b|n|
|c|i|
|d|h|
|e|d|
|f|y|
|g|u|
|h|j|
|i|g|
|j|c|
|k|v|
|l|p|
|m|m|
|n|l|
|o|s|
|p|r|
|q|x|
|r|o|
|s|;|
|t|k|
|u|f|
|v|.|
|w|,|
|x|b|
|y|t|
|z|/|
