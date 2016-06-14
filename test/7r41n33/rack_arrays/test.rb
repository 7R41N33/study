ENV['RACK_ENV'] = 'test'

require_relative './rack_arrays.rb'
require_relative './arrays_middleware'
require 'test/unit'
require 'rack/test'

class RackArraysTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      use User7r41n33::ArraysMiddleware
      run User7r41n33::RackArrays.new
    end.to_app
  end

  def test_swap_min_index
    array = [3, 2, 8, 4, 1, 6, 7, 8, 9]
    get '/swap-min-index', array: array.to_s
    assert last_response.ok?
    assert_equal last_response.body, [3, 2, 8, 4, 9, 6, 7, 8, 1].to_s
  end

  def test_bin_search
    get '/search', array: [1].to_s, query: 900
    assert last_response.ok?
    assert_equal last_response.body.to_i, -1

    get '/search', array: [1].to_s, query: 1
    assert_equal last_response.body.to_i, 0

    get '/search', array: [].to_s, query: 900
    assert_equal last_response.body.to_i, -1

    get '/search', array: [1, 4, 5, 7, 8, 9].to_s, query: 9
    assert_equal last_response.body.to_i, 5

    get '/search', array: [1, 4, 5, 7, 8, 9].to_s, query: 1
    assert_equal last_response.body.to_i, 0

    get '/search', array: [1, 4, 5, 7, 8, 9].to_s, query: 6
    assert_equal last_response.body.to_i, -1
  end
end
