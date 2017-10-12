
fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

def sluggish_octopus(array)
  fish_index = 0

  array.each_with_index do |fish1,index1|
    array.each_with_index do |fish2,index2|
      fish_index = index1 if fish1.length > fish2.length
    end
  end

  array[fish_index]
end


def dominant_octopus(array)
  return array if array.length <=1

  middle = array.length / 2

  left = array.take(middle)
  right = array.drop(middle)
  sorted_left = dominant_octopus(left)
  sorted_right = dominant_octopus(right)
  merge(sorted_left,sorted_right)


end

def merge(arr1,arr2)
  output = []

  until arr1.empty? || arr2.empty?
    if arr1.first.length <= arr2.first.length
      output << arr1.shift
    else
      output << arr2.shift
    end
  end
  output.concat(arr1)
  output.concat(arr2)

  return output
end

def dominant_octopus(array)
  fish_index = 0
  array.each_with_index do |fish,index|
    fish_index = index if fish.length > array[fish_index].length
  end
  return fish_index
end

def slow_dance(direction, tiles_array)
  tiles_array.each_with_index do |tile, index|
    return index if tile == direction
  end
end

tiles_hash = {
    "up" => 0,
    "right-up" => 1,
    "right"=> 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
}

def fast_dance(direction, tiles_hash)
  tiles_hash[direction]
end
