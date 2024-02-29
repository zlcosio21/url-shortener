class Url < ApplicationRecord
  validates :url_complete, uniqueness: true, presence: true
  validates :url_short, uniqueness: true, presence: true, length: { maximum: 5 }
end
