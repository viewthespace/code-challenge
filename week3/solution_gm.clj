;; allocating extra space
(clojure.string/join " " (reverse (clojure.string/split "agora eh vida" #" ")))

;; without allocating extra space
(clojure.string/join (reverse (re-seq #"\w+|\s" "agora eh vida")))
