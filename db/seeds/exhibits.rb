# frozen_string_literal: true

Exhibit.destroy_all

# Past Exhibits
FactoryBot.create(:exhibit, :with_images, :with_end_date, start_date: 60.days.ago, status: :live)
FactoryBot.create(:exhibit, :with_images, :with_end_date, start_date: 40.days.ago, status: :live)

# Ongoing Exhibits
FactoryBot.create(:exhibit, :with_images, status: :live)
FactoryBot.create(:exhibit, :with_images, :with_end_date, status: :live)

# Draft & Archived Exhibits
FactoryBot.create(:exhibit, :with_images, status: :draft)
FactoryBot.create(:exhibit, :with_images, status: :archived)
