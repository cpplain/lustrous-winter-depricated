FactoryGirl.define do
  factory :resource do
    name 'Name'
    description 'Description'
    association :subject
  end
end
