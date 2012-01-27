Install
=======

    # from RubyGems:
    $ gem install role_play

    # or in your Gemfile
    gem 'role_play'

Example
=======

In an ActiveRecord class:

    has_roles :admin, :moderator

Then run:

    rails generate role_play_migration && rake db:migrate

Now your model has these instance methods:

    add_role(:moderator)    #=> true
    remove_role(:admin)     #=> true (doesn't have role)
    has_role?(:admin)       #=> false
    can_have_role?(:writer) #=> false

    # These are auto-generated based on your defined roles.
    # They just call has_role?(name)
    admin?      #=> false
    moderator?  #=> true

---

Tested in Ruby 1.9 and Rails 3.x on Travis CI:
<http://travis-ci.org/mintdigital/role_play>

Copyright (c) 2008 Mint Digital, released under the MIT license
