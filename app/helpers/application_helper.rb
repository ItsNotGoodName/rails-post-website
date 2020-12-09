module ApplicationHelper
  def full_title(title = "")
    return "Post Website" if title.empty?

    title
  end

  def page_param
    params.fetch(:page, 1).to_i
  end
end
