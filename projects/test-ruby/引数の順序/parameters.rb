# 全部並べる
def method(req, opt = 0, *rest, key_req:, key: 0, **key_rest, &b) end;
# 必須引数とオプショナル引数の順番は前後してよいが、opt, req, optはダメ。
def method(opt1 = 0, opt2 = 1, req1, req2)
  p opt1
  p opt2
  p req1
  p req2
end
method(2, 3)
def method(req1, opt1 = 1, req2, req3)
  p req1
  p opt1
  p req2
  p req3
end;
method(0, 2, 3)
def method(key: 0, key_req:)
  p key
  p key_req
end
method(key_req: 1)
