# NStore

Store gives you a thin wrapper around serialize for the purpose of storing hashes in a single column. It's like a simple key/value store baked into your record when you don't care about being able to query that store outside the context of a single record.

You can then declare accessors to this store that are then accessible just like any other attribute of the model. This is very helpful for easily exposing store keys to a form or elsewhere that's already built around just accessing attributes on the model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nstore'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nstore

## Usage

First include NStore module to your class/model and then describe hash-map attribute, list of accessors and couple of options.

```
  class User
    include NStore
    
    attr_accessor :meta
    
    nstore :meta, 
           accessors: {
             profile: {
                 :uid, :url, :avatar,
                 contact: [:email, :telegram, :twitter, :github] 
             },
             account: [:number]        
           },
           prefix: false,
           stringify: false
    ...                
  end
```  

This will generate several setter and getter methods:

```
user = User.new
user.profile_uid = 100
user.profile_url
user.profile_avatar
user.profile_contact_email = 'renat@aomega.co'
user.profile_contact_telegram
user.profile_contact_twitter
user.profile_contact_github
user.account_number = 300

puts user.account_number
=> 300
```

List of options:

- `prefix` - (false by default) allows you to generate methods with the prefix of the original attribute or without
  
  if in the example above, replace `prefix` with `true` value then nstore generates methods:
  `user.meta_profile_uid` ... `user.meta_account_number`
  
- `stringify` - (true by default) this option is useful for serialization of a hash-map attribute into JSON/YAML format or for saving it in 
  a Database HSTORE/JSON/JSONB if you use symbol keys as accessors

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mpakus/nstore.
