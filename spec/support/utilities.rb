include ApplicationHelper
def full_title(page_title)
  base_tite = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_tite
  else
    "#{base_tite} | #{page_title}"
  end
end
