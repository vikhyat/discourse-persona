# name: discourse-persona
# about: persona login provider
# version: 0.1
# author: Vikhyat Korrapati

gem 'omniauth-browserid-discourse', '0.0.2', require_name: 'omniauth-browserid'

class PersonaAuthenticator < ::Auth::Authenticator
  def name
    "persona"
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    result.email = email = auth_token[:info][:email]
    result.email_valid = true

    result.user = User.find_by_email(email)
    result
  end

  def register_middleware(omniauth)
    omniauth.provider :browser_id, name: "persona"
  end
end

auth_provider title: 'with Persona',
              message: 'Authenticating with Mozilla Persona (make sure pop up blockers are not enabled)',
              authenticator: PersonaAuthenticator.new

register_asset "javascripts/persona.js"

register_css <<CSS

.btn-social.persona {
  background: #606060 !important;
}

.btn-social.persona:before {
  content: "]";
}

CSS
