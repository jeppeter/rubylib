class Person
  def self.get_name
    persons_name
  end

  private_class_method def self.persons_name
    "Sam"
  end
end

puts "Hey, " + Person.get_name
puts "Hey, " + Person.persons_name