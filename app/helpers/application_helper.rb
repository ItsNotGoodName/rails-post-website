module ApplicationHelper
  def full_title(title = '')
    'Post Website' if title.empty?
    title
  end
end
