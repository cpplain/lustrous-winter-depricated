FactoryGirl.define do
  factory :organization do
    sequence :name do |n|
      "Name#{n}"
    end
  end
end
