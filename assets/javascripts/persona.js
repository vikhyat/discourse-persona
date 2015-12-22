var LoginView = require('discourse/views/login').default;

LoginView.reopen({
  initPersona: function() {
    var readyCalled = false;
    navigator.id.watch({
      onlogin: function(assertion) {
        if (readyCalled) {
          Discourse.ajax('/auth/persona/callback', {
            type: 'POST',
            data: { 'assertion': assertion },
            dataType: 'json'
          }).then(function(data) {
            Discourse.authenticationComplete(data);
          });
        }
      },
      onlogout: function() {
        if (readyCalled) {
          Discourse.logout();
        }
      },
      onready: function() {
        readyCalled = true;
      }
    });
  },

  didInsertElement: function() {
    this._super();

    // Set a customLogin method on the persona login provider.
    Ember.get("Discourse.LoginMethod.all").forEach(function(loginMethod) {
      if (loginMethod.get("name") == "persona") {
        loginMethod.set("customLogin", function() {
          navigator.id.request();
        });
      }
    });

    // Load the persona script.
    $.getScript("https://login.persona.org/include.js", this.initPersona);
  }
});
