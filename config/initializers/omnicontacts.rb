#check https://github.com/Diego81/omnicontacts for more info

require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "690541467309-6t4h41h2g5sq9kn9bbbpdcr2n1a9dbtd.apps.googleusercontent.com", "eQ9gt3yndbQBiUrtAejPlDGH", {:redirect_path => "/invites/gmail/contact_callback"}
  importer :yahoo, "dj0yJmk9U1czbWd1TTBkMVZiJmQ9WVdrOWNVcFpUa1F5TkdrbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD05ZA--", "66e38501f90d221daef1c954d0772454c2ade722", {:callback_path => '/invites/yahoo/contact_callback'} 
  importer :hotmail, "000000004815B927", "79p5Exk1CecKyNhmF6skq4HhDNe6I-Mi"
end
