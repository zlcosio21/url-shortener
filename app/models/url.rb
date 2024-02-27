class Url < ApplicationRecord
  validates :url_complete, uniqueness: true
  validates :url_short, uniqueness: true
end
