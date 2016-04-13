class ShareAdapter

  class << self
    delegate :url_helpers, to: 'Rails.application.routes' 
  end

  LINKS = {
    facebook: "https://www.facebook.com/sharer/sharer.php?u=",
    twitter: "https://twitter.com/home?status=",
    'google-plus': "https://plus.google.com/share?url="
  }

  def self.share_this(url)
    LINKS.inject({}) do |hash, i|
      key, url_tpl = i
      url_param = URI.encode_www_form_component url
      hash.merge key => url_tpl + url_param
    end
  end

end
