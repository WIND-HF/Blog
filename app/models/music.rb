class Music < ActiveRecord::Base
  validates :name, presence: true
end
