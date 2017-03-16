FactoryGirl.define do
  factory :resource do
    name 'Name'
    description 'Description'
    level 'Beginner'
    free true
    association :subject
  end
end
