class EventAttender < ActiveRecord::Base

belongs_to :account
belongs_to :event
validates_presence_of :event_id
validates_presence_of :account_id
validates_uniqueness_of :account_id, scope: :event_id
end
