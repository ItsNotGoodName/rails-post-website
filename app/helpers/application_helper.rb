module ApplicationHelper
  def full_title(title = '')
    return 'Post Website' if title.empty?

    title
  end
end
