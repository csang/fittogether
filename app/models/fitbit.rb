class Fitbit < ActiveRecord::Base
  belongs_to :accoount
  validates_presence_of :account_id
  
end
