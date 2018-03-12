class Business < ApplicationRecord
  belongs_to :user, optional: true
end
