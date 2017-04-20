(defn find_my_biggest_diff [list]
  (if (empty? list)
    0
    (apply max list)))

(defn build_diffs [list]
  (map-indexed (fn [i num]
    (- (find_my_biggest_diff (drop (+ i 1) list)) num)) list))

(defn max_diff [list]
  (apply max (build_diffs list)))
