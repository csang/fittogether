Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'ISEtMwyHO4vh0DZ7xOXqps2nUFfjTa4e',
    'Q7YPaUqlADfYlDQkOhD-mqJPyc8hCzdJew95OarzqFZsPohQrEmx6EoVo07Sf6x7',
    'fittogetherzap.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end
