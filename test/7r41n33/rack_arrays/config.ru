require './rack_arrays.rb'
require './arrays_middleware'

use User7r41n33::ArraysMiddleware
run User7r41n33::RackArrays.new
