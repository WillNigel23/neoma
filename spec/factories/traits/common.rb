FactoryBot.define do
  trait :skip_validate_to_create do
    to_create { |instance| instance.save(validate: false) }
  end
end
