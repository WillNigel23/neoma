module Spina
  class Mail < ApplicationRecord
    validates :first_name, :last_name, :email, :phone_number, :message, presence: true
  end
end
