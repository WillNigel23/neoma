# == Schema Information
#
# Table name: imports
#
#  id          :bigint           not null, primary key
#  csv_content :text
#  import_type :integer          not null
#  logs        :text
#  status      :integer          default("processing"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Import < ApplicationRecord

  attr_accessor :file

  validates :import_type, presence: true

  enum import_type: {
    articles: 0,
    artists: 1,
    artworks: 2,
    exhibits: 3,
    galleries: 4
  }

  enum status: { processing: 0, success: 1, failed: 2 }

end
