class User7r41n33::ArraysMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if validate(request.params)
      @app.call(env)
    else
      [404, { 'Content-Type' => 'text/html' }, ['Wrong :array parameter']]
    end
  end

  def validate(params)
    return false unless params.include?('array')

    begin
      JSON.parse(params['array'])
      return true
    rescue
      return false
    end
  end
end
