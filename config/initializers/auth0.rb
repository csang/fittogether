Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'oeOfvZxqJotXpmoV1Us0VFlFbP0iNna3',
    '-oaaNrv0GnbmqiSNuk-go-m7Ct-5D7IoF7NnuDBM_ip3sinY4gIQn6wEdl66_SqB',
    'fittogetherzap.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end
