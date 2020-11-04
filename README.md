# Realize

[![Gem Version](https://badge.fury.io/rb/realize.svg)](https://badge.fury.io/rb/realize) [![Build Status](https://travis-ci.org/bluemarblepayroll/realize.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/realize) [![Maintainability](https://api.codeclimate.com/v1/badges/115f0c5a1d0a4cce7230/maintainability)](https://codeclimate.com/github/bluemarblepayroll/realize/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/115f0c5a1d0a4cce7230/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/realize/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This library provides a pluggable and configurable data transformation framework.  The general use-case is:

> We need to be able to configure the data transformation pipeline, within an application, for a system-to-system integration.

It is currently used in production at Blue Marble to power the transformation pipeline within a larger ETL framework.

## Installation

To install through Rubygems:

````
gem install realize
````

You can also add this to your Gemfile:

````
bundle add realize
````

## Examples

### Basic Transformer Example

Here is a simple record we will use for data derivation and transformation:

````ruby
record = {
  id: 1,
  created_at: '2020-03-04T12:34:56Z',
  first: 'Frank',
  last: 'Rizzo'
}
````

Let's say we wanted to retrieve the created_at formatted as: 'MM/DD/YY', we could write:

````ruby
transformers = [
  {
    type: 'r/value/resolve',
    key: :created_at
  },
  {
    type: 'r/format/date',
    output_format: '%D'
  }
]

value = Realize.pipeline(transformers).transform(record) # 03/04/20
````

Notice how all built-in transformers are prefixed with 'r'.  This should help isolate the built-in transformers from potential externally registered transformers.

### Transformer Gallery

Here is a list of each built-in transformer, their options, and what their function is:

#### Collection-oriented Transformers

* **r/collection/at_index** [index]:  Takes an array (or coerces value to an array) and returns the value at the given index position.
* **r/collection/first** []:  Takes an array (or coerces value to an array) and returns the value at the first index position.
* **r/collection/last** []:  Takes an array (or coerces value to an array) and returns the value at the last index position.
* **r/collection/sort** [key, direction]:  Takes an array (or coerces value to an array) and sort it either ascending or descending by some defined key's value.

#### Filtering Transformers

* **r/filter/by_key_record_value** [key, value]: Takes an array (or coerces value to an array) and selects only the records that match the key's value.  In this case the value is derived off of the main record.
* **r/filter/by_key_value_presence** [key]: Takes an array (or coerces value to an array) and selects only the records where the key's value is present (not nil and not empty).
* **r/filter/by_key_record_value** [key, value]: Takes an array (or coerces value to an array) and selects only the records that match the key's value.  In this case, the value is statically defined.
* **r/filter/inactive** [key, value]: Takes an array (or coerces value to an array) and selects only the records where the current time is between the start and end times as derived from the record.  Note that *current time* can be passed in but defaults to current UTC time.

#### Format-oriented Transformers

* **r/format/date** [input_format, output_format]: Parses the incoming value into a Time object using the configured input_format and outputs it as formatted by the configured output_format.
* **r/format/remove_whitespace** []: Removes all whitespace from the incoming value.
* **r/format/string_replace** [original, replacement]: Replaces all occurrences of the configured original value with the replacement value.
* **r/format/string_template** [expression, separator, use_record]: String interpolate an expression using either the record or passed in value.  Nested objects can be handled (i.e. key paths like dot-notation) by passing in a separator.
* **r/format/substring** [start_index, end_index, exclusive]: Cut a string in a given range.  All options are optional.  If a start_index is not provided, the beginning of the string is used.  If no end_index is specified then the end of the string is used.  If exclusive is set to true then the last index position will not be included.  For example: "hellofriend" with a start_index of 0, an end_index of 5, and exclusive as true would yield: "hello".  If exclusive was false then it would yield "hellof"

#### Logical Transformers

* **r/logical/switch** [cases, default_transformers, key]: Provides a value-based logic branching.  If a value matches a specific case, the specific cases transformers will be executed.  If it does not match any case then the default_transformers will be executed.

#### Type Transformers

* **r/type/boolean** [nullable]: Returns `true` if the input is 'truthy', `false` if not.  By default nullable is false, which means a nil input will return false.  Changing this to true will return nil if nil is passed in.  A 'truthy' value is defined as matching: true, t, yes, y, or 1 (case-insensitive).
* **r/type/string** []: Calls `#to_s` on the value so the returned value is guaranteed to be a string type.

#### Value-oriented Transformers

* **r/value/blank** []: Always return a blank string.
* **r/value/map** [values]: Do a lookup on the value using the `values` hash.  If a value is found, then its corresponding value is returned.  If it isn't then the input is returned.
* **r/value/now** [utc_offset]: Returns a Time object, defaulting to UTC offset.  You can optionally pass in a different offset in the FORM: "+/-HH:MM"
* **r/value/null** []: Always returns null.
* **r/value/resolve** [key]: Dynamically resolves a value based on the record's key.  It uses the [Objectable](https://github.com/bluemarblepayroll/objectable) library by default, which provides some goodies like dot-notation for nested objects and type-insensitivity (works for Ruby objects, hashes, structs, etc.)
* **r/value/static** [value]: Always returns a hard-coded value.
* **r/value/uuid** []: Returns a new 36 character UUID (i.e. 6967fec6-bbde-4497-82d9-55ccc7b87cd0)
* **r/value/verbatim** []: Default transformer, simply echos back the input.

### Plugging in Transformers

Custom transformers can be externally created and registered as long as it complies with the general transformer interface:

* constructor accepts keyword arguments from which the configuration provides
* responds to a method called transform with the signature: transform(resolver, value, time, record)

After you have implemented the custom transformer, you can externally register is by:

````ruby
Realize::Transformers.register('some_custom_transformer', SomeCustomTransformer)
````

You should now be able to use the type: 'some_custom_transformer' within your transformation configuration.


## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check realize.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/realize.git)
4. Navigate to the root folder (cd realize)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````
bundle exec guard
````

Also, do not forget to run Rubocop:

````
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update `lib/realize/version.rb` using [semantic versioning](https://semver.org/)
3. Install dependencies: `bundle`
4. Update `CHANGELOG.md` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Code of Conduct

Everyone interacting in this codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bluemarblepayroll/realize/blob/master/CODE_OF_CONDUCT.md).

## License

This project is MIT Licensed.
