class EventKudo < ActiveRecord::Base
belongs_to :event
belongs_to :account

validates_presence_of :account_id, :event_id
validates_uniqueness_of :account_id, scope: :event_id

end
