module ArticlesHelper
  def guardian_body(content)
    if content =~ /^\s*<!--.*-->\s*$/ then
      '<p class="not-available">This article is only available on The Guardian website.</p>'
    else
      content
    end
  end
end