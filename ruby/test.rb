def usage(opts = {})
"""usage #{opts[:name]}

"""
end

puts usage :name => "foo"

def f(opts = {})
  puts opts[:a] || "foo"
end

f()

DEFAULTS = {
  :a => "a",
  :b => "b",
  :c => "c"
}

def g(field, opts = {}, &block)
  puts field
  puts opts[:a] || DEFAULTS.a
  puts opts[:b] || DEFAULTS.b
  puts opts[:c] || DEFAULTS.c

  if block_given?
    puts "!"
  end
end

g :foo, :a => 42, :b => 31, :c => 21 do
  "'-'"
end

module Config 
  def self.h(param, &block)
    ref = {}

    if block_given?
      ref = yield ref
    else
      raise "block required"
    end

    puts ref
  end

  def evaluate(&block)
    @self_before_instance_eval = eval "self", block.binding
    instance_eval &block
  end

  def method_missing(method, *args, &block)
    @self_before_instance_eval.send method, *args, &block
  end
end

Config::h 1 do |v|
  	v.config 42
end

class Base

end
