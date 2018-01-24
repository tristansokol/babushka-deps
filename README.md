# babushka-deps

First you should install [Babushka]("https://babushka.me/installing")

If you want to add apps, you can do it like this:
```
dep 'Postman.app' do
  source 'https://dl.pstmn.io/download/latest/osx'
end
```
but that works on some file types and not others.

TODO:
add all sort of cool plist edits like `defaults write com.blah blah`

https://babushka.me/dep-sources
