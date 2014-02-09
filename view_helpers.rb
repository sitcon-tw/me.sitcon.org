module ViewHelpers
  def bower_tag(path)
    content_tag :script, "", :src => "/bower_components/#{path}.js"
  end
end
