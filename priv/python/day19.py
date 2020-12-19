import re
from lark import Lark

def parse(input):
  input = input.decode()
  input = input.split("\n\n")
  grammar = input[0]
  messages = input[1]

  # Part 2 substitutions
  grammar = re.sub("8: 42", "8: 42 | 42 8", grammar)
  grammar = re.sub("11: 42 31", "11: 42 31 | 42 11 31", grammar)

  grammar = re.sub(r"(\d+)", r"d\1", grammar)

  grammar += "\nstart: d0"

  return [grammar, messages]

def part2(input):
  [grammar, messages] = parse(input)

  parser = Lark(grammar, parser="earley")

  total = 0
  for line in messages.splitlines():
    try:
      parser.parse(line.strip())
      total += 1
    except:
      pass

  return total

if __name__ == "__main__":
  with open("./inputs/day19.txt", "rb") as f:
    input = f.read()

  print(part2(input))
