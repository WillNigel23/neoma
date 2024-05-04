# frozen_string_literal: true

Artist.destroy_all

5.times do
  FactoryBot.create(:artist, :with_images, :with_fullname, status: :live)
end
