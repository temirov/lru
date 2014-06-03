require 'spec_helper'
require_relative '../lru_cache'

describe LruCache do
  before do
    @max = 10
    @total = Random.new.rand(1..4)
    @lru_cache = LruCache.new
  end
  context '#size' do
    it 'returns the default max size of cache' do
      expect(@lru_cache.max).to eq(4)
    end

    it 'returns the defined max size of cache' do
      @lru_cache = LruCache.new(max: @max)
      expect(@lru_cache.max).to eq(@max)
    end

    it 'retains only max elements in the cache' do
      
      lru_cache = LruCache.new max: @max
      key = -> { ("a".."z").to_a.sample }
      value = -> { Random.new.rand(10..100) }
      @max.next.times{ lru_cache.set key.call, value.call }

      expect(lru_cache.max).to eq(@max)
    end
  end
  context '#get' do
    it 'returns the element value given a key' do
      @key = 'E'
      @value = '70'
      @lru_cache.set @key, @value
      expect(@lru_cache.get(@key)).to eq(@value)
    end
  end
  context '#set' do
    it 'adds element to cache' do
      @key = 'E'
      @value = '70'
      @lru_cache.set @key, @value
      expect(@lru_cache.get(@key)).to eq(@value)
    end
    
  end  
end

# You can see

# 1) LRU cache - least recently used cache

# SET - O(1)
# GET  - O(1)

# Size - 4

# A - 10
# B - 20
# C - 30
# D - 50

# GET A => 10
# SET E 70

# A - 10
# E - 70
# C - 30
# D - 50
