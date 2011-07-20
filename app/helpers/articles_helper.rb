module ArticlesHelper
  def guardian_body(content, thumbnail=nil)
    if content =~ /^\s*<!--.*-->\s*$/ || content.nil? then
      "<p class=\"not-available\">This article is only available on The Guardian website.</p>"
    else
      (thumbnail) ? "<img src=\"#{thumbnail}\" alt=\"\">#{content}" : content
    end
  end
end