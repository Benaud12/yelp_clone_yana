FactoryGirl.define do

  factory :user do
    email "test@example.com"
    password  "testtest"
  end

  factory :user2, class: User do
    email "test2@example.com"
    password  "testtest"
  end

end
