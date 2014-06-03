require 'benchmark'
require_relative '../lru_cache'

Benchmark.bmbm do |r|
  min = 400
  max = 4000

  lru_cache = LruCache.new max: min
  key = -> { ("a".."z").to_a.sample }
  value = -> { Random.new.rand(10..100) }
  r.report "Set keys and values for the cache #{min} times" do
    min.times do 
      lru_cache.set key.call, value.call 
    end
  end
  r.report "Get values from cache #{min} times" do
    min.times do 
      lru_cache.get key.call
    end
  end
  r.report "Set keys and values for the cache #{max} times" do
    max.times do 
      lru_cache.set key.call, value.call 
    end
  end
  r.report "Get values from cache #{max} times" do
    max.times do 
      lru_cache.get key.call
    end
  end
end
