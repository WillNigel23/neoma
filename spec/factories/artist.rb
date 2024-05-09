FactoryBot.define do
  factory :artist do
    name { "#{Faker::Artist.unique.name} #{Time.current.to_i}" }
    description { Faker::Quote.famous_last_words }
    role { 'Artist' }

    trait :with_fullname do
      full_name { Faker::Name.unique.name }
    end

    trait :with_images do
      banner { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/banners/banner.jpg').to_s) }
      portrait { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/portraits/portrait.jpg').to_s) }
    end

    trait :with_artworks do
      transient do
        artworks_count { 1 }
      end

      after(:create) do |artist, evaluator|
        create_list(:artwork, evaluator.artworks_count, artist:)
      end
    end

    trait :with_content_sections do
      transient do
        content_sections_count { 1 }
      end

      after(:create) do |artist, evaluator|
        create_list(:content_section, evaluator.content_sections_count, artist:)
      end
    end
  end
end
