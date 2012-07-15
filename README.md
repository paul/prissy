# Prissy

Pretty prints JSON output with even more prettiness, and focus on readability. Also understands things like terminal width, colors, and HTML.

## Installation

Add this line to your application's Gemfile:

    gem 'prissy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prissy

## Usage

### From the command line

```
$ curl -H "Accept: application/json" https://api.github.com/users/paul | prissy
{
  "type":         "User",
  "avatar_url":
    "https://secure.gravatar.com/avatar/d587890d0fcf8f45724baa8b1bfe1bf4?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
  "bio":          "",
  "blog":         "blog.theamazingrando.com",
  "company":      "GitHub",
  "created_at":   "2008-02-11T18:44:09Z",
  "email":        "psadauskas@gmail.com",
  "followers":    35,
  "following":    1,
  "gravatar_id":  "d587890d0fcf8f45724baa8b1bfe1bf4",
  "hireable":     false,
  "html_url":     "https://github.com/paul",
  "id":           184,
  "location":     "Boulder, CO",
  "login":        "paul",
  "name":         "Paul Sadauskas",
  "public_gists": 322,
  "public_repos": 82,
  "url":          "https://api.github.com/users/paul"
}
```

### In Ruby

```ruby
# The easy way
Prissy(json_or_hash)

# With options
Prissy.new(output: :html_inline_style).prissy(json_or_hash)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
