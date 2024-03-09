# frozen_string_literal: true

module Spina
  class Mailinglist < ApplicationRecord
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@]+@[^@]+\z/ }
  end
end
