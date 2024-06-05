Article.destroy_all

5.times do
  FactoryBot.create(:article, :with_content_sections, :as_featured, banner: Image.first, content_sections_count: rand(1..3), status: :live)
end
