# ルビーのハッシュの配列を定義する
array_of_hashes = [
  { name: "Alice", age: 30, active: true },
  { name: "Bob", age: 25, active: false },
  { name: "Charlie", age: 35, active: true },
  { name: "David", age: 28, active: false },
  { name: "Eve", age: 22, active: true },
  { name: "Frank", age: 40, active: false },
  { name: "Grace", age: 30, active: false },
  { name: "Hank", age: 25, active: true },
  { name: "Ivy", age: 30, active: true },
  { name: "Jack", age: 25, active: false },
  { name: "Kathy", age: 35, active: true },
  { name: "Leo", age: 28, active: false },
  { name: "Mona", age: 22, active: true },
  { name: "Nina", age: 40, active: false },
  { name: "Oscar", age: 30, active: false },
  { name: "Paul", age: 25, active: true },
]

# ハッシュの配列を age, active, name の順でソートする
sorted_array_of_hashes = array_of_hashes.sort_by { |h| [h[:age], h[:active] ? 0 : 1, h[:name]] }

# ソート後のハッシュの配列を表示する
sorted_array_of_hashes.each do |h|
  puts h
end