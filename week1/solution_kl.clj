;partial solution - blows up on rows/columns that contain all nils

(defn row [board n]
  (get board n))

(defn board-size [board]
  (count (get board 0)))

(defn cols [board]
  (map #(col board %) (range 0 board-size)))

(defn col [board n]
  ; (map #(get-in board [% n]) (range 1 10)))
  (map #(get % n) board))

;partially implemented
(defn region [board n]
  (def region-size 3)
  (get-in board []))

(defn region-coords-from-position [region]
  (def grid-size 3)
  [(quot region grid-size) (mod region grid-size)])

(defn region-from-offset [offset])
(defn region-offset [n])

(defn valid? [group]
  (println group)
  (def values (filter #(not (nil? %)) group))
  ;this blows up when a group has all nils
  ;because apply tries to call distinct? with no args
  (if-not (empty? values)
    (apply distinct? values)))

;not implemented
(defn check-regions[board])

(defn valid-board? [board]
  (every? identity
    [(every? valid? board) ;check all rows
    (every? valid? cols) ;check all columns
    (check-regions board)]))

;valid input board
(def valid1 [
    [nil nil nil    nil nil nil     1   7   4]
    [nil nil nil    nil nil nil     2   8   5]
    [nil nil nil    nil nil nil     3   9   6]

    [nil nil nil     1   2   3     nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]

    [ 1   2   4      5   6   7      8   3   9 ]
    [nil nil nil    nil nil nil    nil nil nil]
    [nil nil nil    nil nil nil    nil nil nil]
  ])

(valid-board? valid1)
