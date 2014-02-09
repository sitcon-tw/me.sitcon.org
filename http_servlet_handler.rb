class NotFoundHandler
  def initialize(app, file)
    @app = app
    @file = "/#{file}"
  end

  def call(env)
    env["PATH_INFO"] = @file unless is_file_exists?(env)
    status, headers, content = @app.call(env)
    [status, headers, content]
  end

  def is_file_exists?(env)
    path = env["PATH_INFO"][1..-1]
    File.exist?(path) || File.exists?("#{path}.erb")
  end
end

use NotFoundHandler, "404.html"
