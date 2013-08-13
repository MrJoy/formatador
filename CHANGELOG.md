# Changes

## v0.2.5, 2013-08-13

* Switch from Shingo to RSpec.
* Switch from RCov to SimpleCov.
* Update Rake-related deprecation.
* Use a secure source for Bundler.
* Fix typos in `README.rdoc` (pull request from lgn21st, merged by geemus).


## v0.2.4, 2012-10-16

* Metadata fixes, and slight rearranging of constants..


## v0.2.3, 2012-05-18

* Fix nested hashes to allow for keys which contain periods.


## v0.2.2, 2012-05-16

* Allow tests to pass without tty.
* Label test groups.
* Fix for redisplay width.
* Allow tables to use nested hashes.


## v0.2.1, 2011-09-01

* Add examples of table formatting to readme.
* Pass width option when calling `redisplay`.
* Structural improvements / more idiomatic Ruby.
* Change test data to use `Formatador.parse` instead of hard-coding escape
  codes.
* Require `stringio` in tests.
