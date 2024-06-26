FactoryBot.define do
  factory :artwork do
    title { "#{Faker::Movie.unique.title} #{Time.current.to_i}" }
    description { Faker::Quote.famous_last_words }

    size { '12 x 12 inches' }
    medium { 'Oil on Canvas' }
    year { rand(2024..Date.current.year - 10) }

    price { rand(1000..100_000) }

    trait :with_image do
      image { create(:image, :skip_validate_to_create) }
    end

    trait :with_artist do
      artist { create(:artist) }
    end

    trait :as_featured do
      featured_item { create(:featured_item) }
    end
  end
end
