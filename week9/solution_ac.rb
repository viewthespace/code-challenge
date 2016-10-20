exp = [3, 5, 6, 3, 2, 2, 8, 6, 5, 5, 5]

def only_uniq_item(input)
  stack = {}
  input.each do |item|
    stack[item] ? stack.delete(item) : stack[item] = true
  end

  stack.keys.first
end

def only_uniq_item2(input)
  sorted_input = input.sort!
  sorted_input.each_with_index do |item, i|
    locator = i.even? ? 1 : -1
    return item if sorted_input[i + locator] != item
  end
end
