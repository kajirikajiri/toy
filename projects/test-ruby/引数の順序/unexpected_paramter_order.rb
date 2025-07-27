# syntax error found (SyntaxError) unexpected parameter order
def method(key_req:, *rest) end;
def method(a:, b) end;

def method(opt1 = 1, req2, opt2 = 3) end;
# メモ
# claude調査ファイルにも記載あり。すごいな。本当にあってる。
# **オプション引数のグループ化違反**:
# ```ruby
# # エラー例
# def bad_method(a = 1, b, c = 1)  # SyntaxError
# end
# ```