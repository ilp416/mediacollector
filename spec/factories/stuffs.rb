FactoryGirl.define do
  factory :url_stuff, aliases: [:stuff] do
    user
    description "example string"
    type "UrlStuff"
    target_url "http://example.com"
  end

end
