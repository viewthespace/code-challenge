##
## Time Complexity: O(n^2)
## Space Complexity: O(n^2)
##


import toml
import ast
import math

toml_dict = toml.load('../testcases.toml')

class Line:
  def __init__(self, slope, intercept):
    self.slope = slope
    self.intercept = intercept

  def __str__(self):
    return f"{self.slope}x + {self.intercept}"

  def __hash__(self):
    return hash(str(self))

  def __eq__(self, other):
    return self.slope == other.slope and self.intercept == other.intercept

class Point:
  def __init__(self, x, y):
    self.x = x
    self.y = y

  def __str__(self):
    return f"(x: {self.x}, y: {self.y})"

  def __hash__(self):
    return hash(str(self))

  def __eq__(self, other):
    return self.x == other.x and self.y == other.y

class Solution:

  def __init__(self, points_array):
    self.points_array = [Point(point[0], point[1]) for point in points_array]
    self.line_hash = {}

  def max_linear_points(self):
    for point1 in self.points_array:
      for point2 in self.points_array:
        if point1 == point2:
          continue

        line = self.line_from_points(point1, point2)
        if line in self.line_hash:
          self.line_hash[line].add(point1)
          self.line_hash[line].add(point2)
        else:
          self.line_hash[line] = set([point1, point2])
    return self.tally_count(self.line_hash, self.points_array)

  def tally_count(self, line_hash, points_array):
    if len(points_array) == 0:
      return 0
    elif len(points_array) == 1:
      return 1
    else:
      maximum = 0
      for line, point_set in line_hash.items():
        number_of_points = len(point_set)
        if number_of_points > maximum:
          maximum = number_of_points
      return maximum

  def line_from_points(self, point1, point2):
    if point1.x == point2.x:
      return Line(math.inf, point1.x)
    slope = (point2.y - point1.y) / (point2.x - point1.x)
    intercept = point2.y - point2.y * slope
    return Line(slope, intercept)

for test_case_name, input_output in toml_dict['test'].items():
  print(f'Running test: {test_case_name}')
  input_values = ast.literal_eval(input_output['input'])
  expected_output = ast.literal_eval(input_output['output'])
  actual_output = Solution(input_values).max_linear_points()
  print(f"  Input: {input_values}")

  if actual_output == expected_output:
    print("\033[92mPASSED\033[0m")
  else:
    print("\033[91mFAILED\033[0m")
    print(f"  Expected Output: {expected_output}")
    print(f"  Actual Output: {actual_output}\n\n")



