a= ('a'..'z').to_a.permutation(2).to_a
p a.size
b = a.product(('a'..'z').to_a).to_a
p b.size
c = b.map(&:flatten)
d = c.map {|perm| perm.permutation(3).to_a }
p d.size
