
# Table of Contents

1.  [2fa for github accout](#org4124621)
    1.  [How to set two factor authentication for github accout with the use of KeePassXC](#orgec7d6fc)
        1.  [Getting Github account's secret](#org7c184fe)
        2.  [Configuring KeepassXC entry linked to Github's account](#orgcdd864c)

---
author: cissic
date: 2023-09-26 Thu
tags: 'github 2fa keepassxc'
title: '2fa for github accout'
---


<a id="org4124621"></a>

# TODO 2fa for github accout


<a id="orgec7d6fc"></a>

## How to set two factor authentication for github accout with the use of KeePassXC

-   <https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication#configuring-two-factor-authentication-using-a-security-key>
-   <https://keepassxc.org/docs/KeePassXC_UserGuide#_adding_totp_to_an_entry>


<a id="org7c184fe"></a>

### Getting Github account's secret

1.  Go to your github account

2.  In the upper-right corner of any github  page, click your profile photo, then click Settings.

3.  In the "Access" section of the sidebar, click  Password and authentication.

4.  In the "Two-factor authentication" section of the page, click Enable two-factor authentication.

5.  Under "Setup authenticator app" click **setup key** (link below QR code) to see a code, the TOTP secret, that you can manually enter in your TOTP app instead.


<a id="orgcdd864c"></a>

### Configuring KeepassXC entry linked to Github's account

1.  Once obtained setup key, right-click the desired entry (1), choose TOTP → Set up TOTP…​ (2), and the setup dialog will appear. In that dialog, paste the secret code from the website (3), setup any custom settings (rare) (4), then press OK to save the settings.

2.  The TOTP application saves your account on GitHub.com and generates a new authentication code every few seconds. Get the code in KeePassXc by right-click on entry -> TOTP -> Copy TOTP (or just Ctrl+T), then on GitHub type the code into the field under "Verify the code from the app".

3.  Under "Save your recovery codes", click Download to download your recovery codes to your device. Save them to a secure location because your recovery codes can help you get back into your account if you lose access.

4.  After saving your two-factor recovery codes, click I have saved my recovery codes to enable two-factor authentication for your account.

