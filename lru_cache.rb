class LruCache
  def initialize max: 4
    @pipe = ArrayPipe.new max: max
  end
  def get key
    @pipe.find key
  end
  def set key, value
    @pipe.add key, value
  end
  def size
    @pipe.count
  end
  def max
    @pipe.max
  end
  class ArrayPipe
    attr_accessor :max

    def initialize max: 4, indices: []
      @max = max
      @pipe = {}
      @indices = indices
    end
    
    def add key, value      
      @indices.insert 0, key

      if full?
        @pipe.delete @indices[max.pred] 
        @indices.delete_at max.pred
      end

      @pipe.merge! key => value
    end
    
    def find key
      @pipe[key]
    end
    
    def full?
      @pipe.count == @max
    end
  end
end
