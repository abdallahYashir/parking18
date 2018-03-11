class Park < ApplicationRecord
  belongs_to :business
  validates :number, :business, presence:true
end
