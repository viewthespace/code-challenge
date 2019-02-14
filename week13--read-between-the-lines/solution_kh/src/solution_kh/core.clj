(ns solution-kh.core
  (:gen-class))

(defn d
  "Decrypt array"
  [xs] (let [
             sum (/ (reduce + xs) (- (count xs) 1))
             ]
         (map #(- sum %) xs)))

(defn -main
  "Decrypt [ 14 13 12 11 10 ]"
  [& args]
  (println (d [ 14 13 12 11 10 ])))
