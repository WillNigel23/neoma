# == Schema Information
#
# Table name: spina_mails
#
#  id           :bigint           not null, primary key
#  email        :string           not null
#  first_name   :string           not null
#  last_name    :string           not null
#  message      :text             not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artwork_id   :integer
#
module Spina
  class Mail < ApplicationRecord

    validates :first_name, :last_name, :email, :phone_number, :message, presence: true

  end
end
