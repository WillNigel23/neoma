Artwork.destroy_all

5.times do
  FactoryBot.create(:artwork, :as_featured, status: :live, image: Image.last, artist: Artist.live.sample)
end
