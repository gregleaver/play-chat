gravatarID = (email) -> hex_md5(email.trim().toLowerCase())
window.gravatar = (email) -> "http://www.gravatar.com/avatar/" + gravatarID(email) + "?s=50&d=identicon"
