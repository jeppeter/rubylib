p File.superclass          #=> IO
p IO.superclass            #=> Object
p Object.superclass        #=> BasicObject
class Foo; end
class Bar < Foo; end
p Bar.superclass           #=> Foo