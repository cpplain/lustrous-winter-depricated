FactoryGirl.define do
  factory :resource_type do
    sequence :resource_type do |n|
      "Type#{n}"
    end
  end
end
