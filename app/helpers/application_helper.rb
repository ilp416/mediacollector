module ApplicationHelper

  def shares_for_this(url)
    ShareAdapter.share_this url
  end

  def shares_current_url
    ShareAdapter.share_this url_for(:only_path => false)
  end
end
