import httplib, urllib

# Application specific variables
application_token = "aaUeNnUF4j63ehnvchsuJ9K7CCH7N5"
user_token = "u1ToGHejYyUn25bNuECZcVKM8vYttw"

# Message specific variables
title = "files moved to our_bible"
message = "images from bananapi are now on our_bible"
url = "http://stewartcummings.com"
# To remove any of these fields you will need to remove them
# from the conn.request() below

# Start your connection with the Pushover API server
conn = httplib.HTTPSConnection("api.pushover.net:443")

# Send a POST request in urlencoded json
conn.request("POST", "/1/messages.json",
urllib.urlencode({
"token": application_token,
"user": user_token,
"title": title,
"message": message,
"url": url,
}), { "Content-type": "application/x-www-form-urlencoded" })

# Listen for any error messages or other responses
conn.getresponse()

