class Llama < ActiveRecord::Base
  has_many :garments
  belongs_to :user

  def self.qualities_for_select
    return ["High", "Medium", "Low"]
  end
end