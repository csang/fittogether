class FitspotMember < ActiveRecord::Base
belongs_to :account
belongs_to :fitspot
validates_presence_of :fitspot_id
validates_presence_of :account_id
end
