require 'byebug'
require 'json'

content = File.read('dolphins.gml')
content.gsub!("\n", "")

matches = 
  content.scan(/node *\[ *id (\d+) *label \"([a-zA-Z0-9]*)\"/m)

nodes = {}
matches.each do |match| 
  nodes[match[0]] = {
    id: match[0], 
    name: match[1], 
    size: 1,
    imports: []
  } 
end

matches = 
  content.scan(/edge *\[ *source (\d+) *target (\d+)/m)

matches.each do |match|
  source = match[0]
  target = match[1]
  nodes[source][:imports] << nodes[target][:name]
end

File.write('data.json', JSON.pretty_generate(nodes.values))
# byebug

puts 'the end'