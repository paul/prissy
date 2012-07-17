# Prissy

Pretty prints JSON output with even more prettiness, and focus on readability. Also understands things like terminal width, colors, and HTML.

## Why another one?

There's plenty of JSON formatters out there, in tons of languages. While none of them are perfect, this one is special because:

 * Left-align key names. Column-align the values.
 * When nested objects or arrays are short and simple, keep them in the same line as the key. If they're longer, or contain further nestings, then make them multiline.
 * Terminal width aware, so that things don't wrap if we can help it.
 * Colorized terminal output optional.
 * TODO: (colored) HTML output, so we don't have to roundtrip through yet another syntax library.


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
$ cat example_input.json | prissy
{
  "array":         [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve"
  ],
  "false":         false,
  "inline_array":  ["one", "two", "three"],
  "inline_object": {"foo": "bar"},
  "null":          null,
  "number":        42.0,
  "object":        {
    "baz":  "bax",
    "foo":  "bar",
    "more": [1, 2, 3]
  },
  "string":        "a text string",
  "true":          true
}

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
Prissy.new(width: 120, color: false).prissy(json_or_hash)
```

## Output:

![prissy output](https://github-images.s3.amazonaws.com/skitch/2._psadauskas%40Pauls-GitHub-MBP__%7E_Code_personal_prissy_%28zsh%29-20120717-163756.png)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
