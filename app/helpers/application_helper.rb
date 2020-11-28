module ApplicationHelper
  def full_title(title = "")
    return "Post Website" if title.empty?

    title
  end

  def goto_or_goback(id)
    if params[:goto].nil?
      redirect_back fallback_location: root_path
    else
      redirect_to "#{params[:goto]}##{id}"
    end
  end
end
