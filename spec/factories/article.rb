FactoryBot.define do
  factory :article do
    title { "#{Faker::Movie.unique.title} #{Time.current.to_i}" }
    subtitle { Faker::Movie.quote }
    description { Faker::Movie.quote }
    date { Date.current }

    trait :with_banner do
      banner { create(:image, :skip_validate_to_create) }
    end

    trait :with_content_sections do
      transient do
        content_sections_count { 1 }
      end

      after(:create) do |article, evaluator|
        article.content_sections << create_list(:content_section, evaluator.content_sections_count)
      end
    end
  end
end
