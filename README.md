QueueClassic Mailer
===================

Add to a Rails 3.x project to send email in the background using QueueClassic. This gem was inspired by ResqueMailer, https://github.com/zapnap/resque_mailer. This is a fork from the original maintained by [Rainforest QA](https://github.com/rainforestapp).

**WARNING: USE AT OWN RISK! THIS GEM IS CONSIDERED EXTREME ALPHA!**

[![Build Status](https://secure.travis-ci.org/zerobearing2/qc-mailer.png)](http://travis-ci.org/zerobearing2/qc-mailer)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/zerobearing2/qc-mailer)

Usage
-----

Install as gem

    gem install qc-mailer

Add to Gemfile

    gem "qc-mailer"

Include QC::Mailer in your ActionMailer subclass(es) like this:

```ruby
class MyMailer < ActionMailer::Base
  include QC::Mailer
end
```

Now, when ```MyMailer.subject_email(params).deliver``` is called, an entry will be created in the job queue.

Note that you can still have mail delivered synchronously by using the bang method variant:
```ruby
MyMailer.subject_email(params).deliver!
```

If you want to set a different default queue name for your mailer, you can change the default_queue property like so:
```ruby
# config/initializers/qc_mailer.rb
QC::Mailer.default_queue = 'application_specific_mailer'
```

Development
-----------

To get a working development environment, do the following;

```bash
git clone https://github.com/rainforestapp/qc-mailer.git
cd qc-mailer
bundle
createdb queue_classic_test
rake
```

TODO
----

 - TBD


Meta
----

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
