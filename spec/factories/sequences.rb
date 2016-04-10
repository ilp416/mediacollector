FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :password do |n|
    rand(36**10).to_s(36)
  end

  sequence :nickname do |n|
    "IOann-#{n}"
  end
end
