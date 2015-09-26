(defn valid? [group]
  (def values (remove nil? group))
  (if (empty? values) true (apply distinct? values)))

(defn cols [board]
  (partition (count board) (apply interleave board)))

(defn regions-row [rows]
  (map flatten (partition 3 (cols rows))))

(defn regions [board]
  (mapcat regions-row (partition 3 board)))

(defn valid-board? [board]
  (every? valid? (concat board (cols board) (regions board))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Test cases
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;tests
;(map valid-board? (concat valid-inputs invalid-inputs))

(def valid-inputs [
  [
    [nil nil nil    nil nil nil     1   7   4 ]
    [nil nil nil    nil nil nil     2   8   5 ]
    [nil nil nil    nil nil nil     3   9   6 ]

    [nil nil nil     1   2   3     nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]

    [ 1   2   4      5   6   7      8   3   9 ]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
  ]

  [
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]

    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]

    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
  ]

  [
    [ 1   9  nil    nil nil nil    nil nil  8 ]
    [ 2   8  nil    nil  9  nil    nil nil nil]
    [ 3   7  nil    nil nil nil    nil nil nil]
    [ 4  nil nil    nil nil nil    nil nil nil]
    [ 5  nil nil    nil  1  nil    nil nil nil]
    [ 6  nil nil    nil  2  nil    nil nil nil]
    [ 7   3  nil    nil nil nil    nil nil nil]
    [ 8   2  nil    nil nil nil    nil nil nil]
    [ 9   1  nil    nil nil nil    nil nil  4 ]
  ]])

(def invalid-inputs [
  [
    [nil nil nil    nil nil nil     1   7   9 ]
    [nil nil nil    nil nil nil     2   8   5 ]
    [nil nil nil    nil nil nil     3   4   6 ]

    [nil nil nil     1   2   3     nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]

    [ 1   2   4      5   6   7      8   3   9 ]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
  ]

  [
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]

    [ 1  nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil  1     nil nil nil    nil nil nil]

    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
  ]

  [
    [ 1   9  nil    nil nil nil    nil nil  8 ]
    [ 2   8  nil    nil  8  nil    nil nil nil]
    [ 3   7  nil    nil nil nil    nil nil nil]

    [ 4  nil nil    nil nil nil    nil nil nil]
    [ 5  nil nil    nil  1  nil    nil nil nil]
    [ 6  nil nil    nil  2  nil    nil nil nil]

    [ 7   3  nil    nil nil nil    nil nil nil]
    [ 8   2  nil    nil nil nil    nil nil nil]
    [ 9   1  nil    nil nil nil    nil nil  4 ]
  ]])
