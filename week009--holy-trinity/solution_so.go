package main;
import "fmt"

func ht(nums [11]int) int {
  var counter int = 0;
  for _, num := range nums {
    counter ^= num
  }
  return counter;
}

func main() {
  nums := [11]int{3, 5, 6, 3, 2, 2, 8, 6, 5, 5, 5}
  fmt.Printf("%d\n", ht(nums));
}