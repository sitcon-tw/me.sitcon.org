class NotFoundHandler
  def initialize(app, file)
    @app = app
    @file = "/#{file}"
  end

  def call(env)
    unless File.exists?(env["PATH_INFO"][1..-1])
      env["PATH_INFO"] = @file
    end
    status, headers, content = @app.call(env)
    [status, headers, content]
  end
end

use NotFoundHandler, "404.html"
