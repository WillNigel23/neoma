# frozen_string_literal: true

Artwork.destroy_all

5.times do
  FactoryBot.create(:artwork, :with_image, status: :live, artist: Artist.live.sample)
end
