#! /usr/bin/env ruby

hash = { "k1" => "v1", "k2" => "v2"}
string = ""
hash.each {|k,v| string << "#{k} is #{v}\n"}
puts string