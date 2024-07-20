require 'rails_helper'

describe 'yield' do
  it 'ブロックを呼び出す(&block省略あり)' do
    def call_block
      yield
    end

    expect { |b| call_block(&b) }.to yield_control.once
  end

  it 'ブロックを呼び出す(&block省略なし)' do
    def call_block(&block)
      block.call
    end

    expect { |b| call_block(&b) }.to yield_control.once
  end

  it '引数を渡してブロックを呼び出す' do
    def call_block_with_argument
      yield('argument')
    end

    expect { |b| call_block_with_argument(&b) }.to yield_with_args('argument')
  end
end
