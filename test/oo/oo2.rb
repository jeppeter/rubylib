fred = Class.new do
  def meth1
    p "hello"
  end
  def meth2
    p "bye"
  end
end

a = fred.new     #=> #<#<Class:0x100381890>:0x100376b98>
a.meth1          #=> "hello"
a.meth2          #=> "bye"