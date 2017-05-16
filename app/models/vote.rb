class Vote < ApplicationRecord
  belongs_to :photograph
  belongs_to :user
end
