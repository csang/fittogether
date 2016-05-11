class Review < ActiveRecord::Base
  belongs_to :account
  
   validates_presence_of :review
end
