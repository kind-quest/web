include ActionDispatch::TestProcess

FactoryGirl.define do
 factory :act do
   association :user, factory: :user
   description { Faker::Lorem.paragraph }

   image do
     fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Capture.PNG'), 'image/png')
   end

   trait :with_likes do
     after :build do |act|
       act.likes << create_list(:like, 10)
     end
   end
 end
end
