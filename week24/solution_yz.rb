def songs_about_rain_v1(elevations)
  collecting = false
  max_height = 0
  max_height_index = nil
  min_height = nil
  reservoir = 0

  (0...elevations.length).to_a.each do |index|
    current_height = elevations[index]
    if !collecting
      if current_height >= max_height
        max_height = current_height
        max_height_index = index
      else
        min_height = current_height
        collecting = true
      end
      next
    else
      if current_height > min_height
        fill_height = [current_height, max_height].min
        (max_height_index...index).to_a.each do |fill_index|
          fill_depth = fill_height - elevations[fill_index]
          if fill_depth > 0
            reservoir += fill_depth
            elevations[fill_index] = fill_height
          end
        end
        min_height = fill_height
      else
        min_height = current_height
      end

      if current_height >= max_height
        max_height = current_height
        max_height_index = index
      end
    end
  end

  reservoir
end

def songs_about_rain_v2(elevations)
  # WOMP WOMP
end

[:songs_about_rain_v1].each do |method_name|
  [
    { output: 4, input: [ 1, 3, 4, 2, 3, 5, 4, 5 ] },
    { output: 12, input: [ 1, 2, 2, 4, 1, 2, 1, 3, 1, 5, 1 ] },
    { output: 7, input: [ 1, 2, 2, 4, 1, 2, 1, 3, 1, 3, 1 ] }
  ].each do |test_case|
    puts "Raining on #{test_case[:input]} using :#{method_name}..."
    result = send(method_name, test_case[:input])
    status = (result == test_case[:output]) ? "Success" : "FAILURE"
    puts "-> #{status}! Expected #{test_case[:output]}, got #{result}"
  end
  puts ''
end
