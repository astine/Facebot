Facebot.rb
==========

Nota Bene
---------

FaceBot uses an older version of the Facebook API and doesn't work anymore. I don't currently have the inclination to make it work, unfortunately.

---

Facebot is a trivial ruby Facebook bot meant as a simple probe into writing a personal bot on Facebook. Currently Facebot sends a "Happy Birthday!" message to each of a user's friends on their birthdays. There is plenty of room to expand the code to send customized messages per person, congratulate friends on other events, send out mass, scheduled messages, and really anything you can imagine a bot masquerading as yourself doing.

Usage is simple, run:

    ruby facebot.rb -t "oauth_access_token"

To get an OAuth access token, use Facebook's [Graph API Explorer](https://developers.facebook.com/tools/explorer/).
