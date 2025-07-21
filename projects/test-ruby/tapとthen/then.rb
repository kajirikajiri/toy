# 無理矢理書くとこうなるが、then無しでもかける。
puts ['a', 'c', 1, nil, 'z', 'b', 'd']
  .then { it.filter { it.is_a? String } }
  .then { it.sort }
  .then { it.join }
# then無し版。
puts ['a', 'c', 1, nil, 'z', 'b', 'd']
  .filter { it.is_a? String }
  .sort
  .join

# 引数なしだと、Enumeratorを返す
p 1.then.detect(&:odd?) # 条件に合致する値、1が返る。
p 2.then.detect(&:odd?) # 条件に合致する値がないので、nilが返る。ｓ