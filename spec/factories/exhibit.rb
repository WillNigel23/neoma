# frozen_string_literal: true

FactoryBot.define do
  factory :exhibit do
    title { Faker::Movie.unique.title }
    subtitle { Faker::Movie.quote }
    summary { Faker::Movie.quote }
    start_date { Date.current }

    trait :with_end_date do
      end_date { start_date + 30.days }
    end

    trait :with_images do
      banner { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/banners/banner.jpg').to_s) }
      poster { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/portraits/portrait.jpg').to_s) }
    end

    trait :with_artists do
      transient do
        artists_count { 1 }
      end

      after(:create) do |exhibit, evaluator|
        create_list(:artist, evaluator.artists_count, exhibits: [exhibit])
      end
    end
  end
end
