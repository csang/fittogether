class AccountGym < ActiveRecord::Base

	serialize :address, Array
	serialize :specialties, Array
	serialize :groupclasses, Array
	serialize :amenities, Array
	serialize :timings, Hash
	belongs_to :account

end
