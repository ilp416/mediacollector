module UrlClicker
  def click_link_to(url)
    find("a[href='#{url}']").click
  end
end
