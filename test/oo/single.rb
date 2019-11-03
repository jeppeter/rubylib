
class InnerSingle
	attr_reader :val
	def initialize(v)
		@val =v
	end

	def initialize()
		@val = 0
	end

	def set_v(v)
		@val = v
	end

	def to_s()
		s = sprintf("single %s #{@val}", self.inspect);
		return s
	end
end

class Singleton
	@@singcls = nil
	def Singleton.create(v)
		if @@singcls == nil then
			@@singcls = InnerSingle.new()
		end
		@@singcls.set_v(v)
		return @@singcls
	end
end

idx = 0
while idx < ARGV.length 
	c = Singleton.create(ARGV[idx].to_i)
	puts "c #{c}"
	idx += 1
end