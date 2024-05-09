FactoryBot.define do
  factory :exhibit do
    title { "#{Faker::Movie.unique.title} #{Time.current.to_i}" }
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

    trait :with_artworks do
      transient do
        artworks_count { 1 }
      end

      after(:create) do |exhibit, evaluator|
        create_list(:artwork, evaluator.artworks_count, exhibits: [exhibit])
      end
    end

    trait :with_content_sections do
      transient do
        content_sections_count { 1 }
      end

      after(:create) do |exhibit, evaluator|
        create_list(:content_section, evaluator.content_sections_count, exhibit:)
      end
    end
  end
end
