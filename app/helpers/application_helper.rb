module ApplicationHelper
  def full_title(title = "")
    return "Post Website" if title.empty?

    title
  end

  def goto_or_goback(id, prefix = "")
    if params[:goto].nil?
      redirect_back fallback_location: root_path
    else
      if id.nil?
        redirect_to params[:goto]
      else
        redirect_to "#{params[:goto]}##{prefix}#{id}"
      end
    end
  end
end
