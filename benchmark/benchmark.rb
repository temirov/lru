require 'benchmark'
require_relative '../lru_cache'

Benchmark.bmbm do |r| 
  max = 400
  lru_cache = LruCache.new max: max
  key = -> { ("a".."z").to_a.sample }
  value = -> { Random.new.rand(10..100) }
  r.report "Set keys and values for the cache" do
    400.times do 
      lru_cache.set key.call, value.call 
    end
  end
  r.report "Get values from cache" do
    400.times do 
      lru_cache.get key.call
    end
  end
  r.report "Set keys and values for the cache" do
    4000.times do 
      lru_cache.set key.call, value.call 
    end
  end
  r.report "Get values from cache" do
    4000.times do 
      lru_cache.get key.call
    end
  end
end
