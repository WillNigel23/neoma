# frozen_string_literal: true

# == Schema Information
#
# Table name: spina_mailinglists
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Spina
  class Mailinglist < ApplicationRecord
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@]+@[^@]+\z/ }
  end
end
