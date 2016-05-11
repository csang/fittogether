class Invitation < ActiveRecord::Base
   validates_presence_of :email, :invited_by 
end
