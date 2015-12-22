# name: discourse-persona
# about: persona login provider
# version: 0.2
# author: Vikhyat Korrapati
# url: https://github.com/vikhyat/discourse-persona

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

auth_provider authenticator: PersonaAuthenticator.new

register_asset "javascripts/persona.js"

register_css <<CSS

.btn-social.persona {
  background: #606060 !important;
}

.btn-social.persona:before {
  content: "";
  background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMCIgaGVpZ2h0PSIxNSIgdmlld0JveD0iMCAwIDIwIDE1Ij48ZyBpZD0iZzEwIiB0cmFuc2Zvcm09Im1hdHJpeCgxLjI1LDAsMCwtMS4yNSwwLDE1KSI+PHBhdGggaWQ9InBhdGgyMTAiIGQ9Ik0gMC41NzExMDgsMTIgQyAwLjI1NTQxMiwxMiAwLDExLjc0NDM3OSAwLDExLjQyODQ5IEwgMCwwLjU3MTMwOSBDIDAsMC4yNTU3NDEgMC4yNTU0MTIsMCAwLjU3MTEwOCwwIEwgMTAuNDMzNjE0LDAgMTUuNTc2NTk5LDUuOTk5OTUgMTAuNDMzNjE0LDEyIDAuNTcxMTA4LDEyIFogTSA2LjI4ODgxNCw5Ljk2MDI5OCBjIDAuODQ5ODM4LDAgMS41NDQzNDQsLTAuNzIyNzYyIDEuNTk2Mjc1LC0xLjgxNDAyNyAwLjA3OTAyLC0wLjEyOTk4OSAwLjEyMzA2OSwtMC4yNzE1NDQgMC4xMjMwNjksLTAuNDE5OTU2IDAsLTAuMjE2MzI3IC0wLjA5MjMzLC0wLjQxODM4IC0wLjI1MjM1NiwtMC41ODk5NjUgQyA3LjYxODc1Miw2LjY5MDY2NCA3LjM4MzY0OSw2LjMwMTA3OSA3LjA4OTAwOCw2LjA0MjU3OCBsIDAsLTAuNTIwODU5IGMgMC4wMDc1LC0wLjAwNDYgMC4wMTUxOSwtMC4wMDg3IDAuMDIyNTcsLTAuMDEzMjQgQyA3LjQxOTA1OCw1LjMyMjkgNy42MzU5MTksNS4zNzIyMDcgOC41MjE4OTcsNS4wMjQwMjkgOS40MDc4MTIsNC42NzU4NTEgOS41MzQzMjYsMi43Mzk4OTYgOS41MzQzMjYsMi43Mzk4OTYgYyAwLDAgLTAuODIwNDIyLC0wLjExMDMzIC0zLjI0NzcxNiwtMC4xMTAzMyAtMi40MjcxNjUsMCAtMy4yNDMwMDIsMC4xMTAzMyAtMy4yNDMwMDIsMC4xMTAzMyAwLDAgMC4xMjY1NzksMS45MzU5NTUgMS4wMTI0MjksMi4yODQxMzMgMC44ODU5MTQsMC4zNDgxNzggMS4xMDI5MzIsMC4yOTg4NzEgMS40MTAyMTksMC40ODQ0NSAwLjAwNzQsMC4wMDQ1IDAuMDE1MDQsMC4wMDg3IDAuMDIyODcsMC4wMTMyNCBsIDAsMC41MjA3NTggQyA1LjE5NDM1Niw2LjMwMDk3OSA0Ljk1OTI0NSw2LjY5MDUzNiA0LjgyMjEzMSw3LjEzNjM1IDQuNjYyMDM2LDcuMzA3OTM1IDQuNTY5Nzc2LDcuNTA5OTg4IDQuNTY5Nzc2LDcuNzI2MzE1IGMgMCwwLjE0ODQxMiAwLjA0NDA0LDAuMjg5OTY3IDAuMTIyODY4LDAuNDE5OTU2IDAuMDUyMzIsMS4wOTEyNjUgMC43NDY3ODYsMS44MTQwMjcgMS41OTYxNzUsMS44MTQwMjcgeiIgc3R5bGU9ImZpbGw6I2ZmZmZmZjtzdHJva2U6bm9uZSIgLz48L2c+PC9zdmc+Cg==");
  background-size: auto 15px;
  background-repeat: no-repeat;
  width: 20px;
  height: 15px;
  display: inline-block;
  margin-bottom: -3px;
}

CSS
