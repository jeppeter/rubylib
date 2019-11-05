

class HashTableInner
	def initialize()
		puts "create HashTableInner"
	end
end

class HashTable
	@@loggers = Hash.new(nil)
	def HashTable.__inner_create(name)
		if @@loggers[name] == nil then
			@@loggers[name] = HashTableInner.new()
		end
		return @@loggers[name]
	end

	def HashTable.create(name=nil)
		return HashTable.__inner_create(name)
	end
end


c = HashTable.create()
d = HashTable.create("cc")