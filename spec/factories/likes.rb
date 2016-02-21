FactoryGirl.define do
  factory :like do
     association :user, factory: :user
     association :act, factory: :act
  end
end
