class EventComment < ActiveRecord::Base
belongs_to :event
belongs_to :account

validates_presence_of :account_id, :event_id

end
