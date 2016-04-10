FactoryGirl.define do

  factory :url_stuff, aliases: [:stuff] do
    user
    description "example string"
    type "UrlStuff"
    target_url "http://example.com"
  end

  factory :picture_stuff do
    user
    description "example string"
    type "PictureStuff"
    picture { File.new(Rails.root.join("spec/factories/rails.jpg")) }
  end

end
