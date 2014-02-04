class Hash
  # Copied from active_support
  # http://apidock.com/rails/Hash/deep_merge%21
  def deep_merge!(other_hash, &block)
    other_hash.each_pair do |k,v|
      tv = self[k]
      if tv.is_a?(Hash) && v.is_a?(Hash)
        self[k] = tv.deep_merge(v, &block)
      else
        self[k] = block && tv ? block.call(k, tv, v) : v
      end
    end
    self
  end

  def deep_merge(other_hash, &block)
    dup.deep_merge!(other_hash, &block)
  end
end