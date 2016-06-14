require_relative '../arrays/solution.rb'
require 'json'

class User7r41n33::RackArrays
  def call(env)
    @request = Rack::Request.new(env)
    @array = JSON.parse(@request.params['array'])

    begin
      path_info = prepare_path
      public_send(path_info)
    rescue NoMethodError
      [404, { 'Content-Type' => 'text/html' }, ['No method found.']]
    rescue StandardError => e
      [404, { 'Content-Type' => 'text/html' }, [e.message]]
    end
  end

  def swap_min_index
    [200, { 'Content-Type' => 'text/html' }, [User7r41n33::Arrays.swap_min_max(@array).to_s]]
  end

  def search
    raise 'Parameter :query required' unless @request.params.include?('query')
    query = @request.params['query'].to_i
    [200, { 'Content-Type' => 'text/html' }, [User7r41n33::Arrays.search(@array, query).to_s]]
  end

  private
  def prepare_path
    @request.path_info.tr('-', '_').tr('/', '').downcase
  end
end
