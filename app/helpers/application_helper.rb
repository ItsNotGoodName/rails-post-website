module ApplicationHelper
  def full_title(title = '')
    if title.empty?
      title
    else
      'Post Website'
    end
  end
end
