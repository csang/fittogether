class AccountTrainer < ActiveRecord::Base
  serialize :certificates, Array
  serialize :workout_tips, Array
  belongs_to :account
  
  before_validation do |model|
  model.certificates.reject!(&:blank?) if model.certificates
  model.workout_tips.reject!(&:blank?) if model.workout_tips
  end

end
