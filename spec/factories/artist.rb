# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    name { Faker::Artist.unique.name }
    description { Faker::Quote.famous_last_words }
    role { 'Artist' }

    trait :with_fullname do
      full_name { Faker::Name.unique.name }
    end

    trait :with_images do
      banner { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/banners/banner.jpg').to_s) }
      portrait { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/portraits/portrait.jpg').to_s) }
    end

    trait :with_exhibits do
      transient do
        exhibits_count { 1 }
      end

      after(:create) do |artist, evaluator|
        create_list(:exhibit, evaluator.exhibits_count, artists: [artist])
      end
    end
  end
end
