class Llama < ActiveRecord::Base
  has_many :garments
  belongs_to :user
end