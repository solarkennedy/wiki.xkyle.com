[Google Authenticator](Google Authenticator "wikilink") is a time based
one time password thing that runs on smartphones. It is open source, and
is included in modern ubuntu repositories.

### Install App

Find it in the market/appstore/etc

### Install Pam Module

`apt-get install libpam-google-authenticator` `or compile it:`\
`hg clone `[`https://code.google.com/p/google-authenticator/`](https://code.google.com/p/google-authenticator/)

### Configure Pam

Stick this line at the top of any pam config to use the module: auth
required pam\_google\_authenticator.so

Other ways:

    # If the user is NOT in group "otp_users", skip next module
    auth [success=1 default=ignore] pam_succeed_if.so user notingroup otp_users
    auth       required     pam_google_authenticator.so secret=/var/run/user/${USER}/.google_authenticator
    auth       include      password-auth

### Configure User

As the user run: google-authenticator

It will setup a .google\_authenticator file, and give you a QR code to
scan for the app. Alternatively you can type in the secret manually.

### Issues

If you use public key authentication, it bypasses PAM, and never gets to
the google authenticator pam module. [Google Issue
40](http://code.google.com/p/google-authenticator/issues/detail?id=40)
[Another Guy Who Confirms
this](http://blog.endpoint.com/2011/03/google-2-factor-authentication.html)

[Category:Google
Authenticator](Category:Google Authenticator "wikilink") <Category:SSH>
<Category:Linux> <Category:Security>
