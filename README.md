# babushka-deps

To get going, first you should install [Babushka]("https://babushka.me/installing")

Then you can clone your deps into a good spot:
```
git clone git@github.com:tristansokol/babushka-deps.git ~/.babushka/deps
```

And then you can do all those deps!
```
babushka personal:"base"
```



If you want to add apps, you can do it like this:
```
dep 'Postman.app' do
  source 'https://dl.pstmn.io/download/latest/osx'
end
```
but that works on some file types and not others.




TODO:
add all sort of cool mac preference edits like `defaults write com.blah blah`
check for ssh key
check for bash profile

https://babushka.me/dep-sources
