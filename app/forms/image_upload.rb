class ImageUpload

  include ActiveModel::Model
  attr_accessor :files

  validates :files, presence: true

end
