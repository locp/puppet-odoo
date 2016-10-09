require 'beaker-rspec'
require 'pry'

# Don't run these tests on the following platforms
confine :except, :platform => 'solaris'
confine :except, :platform => 'windows'
confine :except, :platform => 'aix'

hosts.each do |host|
  
end
