# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'collection/at_index'
require_relative 'collection/first'
require_relative 'collection/last'
require_relative 'collection/sort'

require_relative 'filter/by_key_record_value'
require_relative 'filter/by_key_value'
require_relative 'filter/by_key_value_presence'
require_relative 'filter/inactive'

require_relative 'format/date'
require_relative 'format/lowercase'
require_relative 'format/remove_whitespace'
require_relative 'format/string_replace'
require_relative 'format/string_template'
require_relative 'format/substring'
require_relative 'format/uppercase'

require_relative 'logical/switch'

require_relative 'type/boolean'
require_relative 'type/string'

require_relative 'value/blank'
require_relative 'value/map'
require_relative 'value/now'
require_relative 'value/null'
require_relative 'value/resolve'
require_relative 'value/static'
require_relative 'value/uuid'
require_relative 'value/verbatim'

module Realize
  # Transformers for building individual transformation step objects.  Used like this:
  # Transformers.make(type: '')
  # Transformers.make(type: 'map')
  # etc...
  class Transformers
    acts_as_hashable_factory

    register 'r/collection/at_index',          Collection::AtIndex
    register 'r/collection/first',             Collection::First
    register 'r/collection/last',              Collection::Last
    register 'r/collection/sort',              Collection::Sort

    register 'r/filter/by_key_record_value',   Filter::ByKeyRecordValue
    register 'r/filter/by_key_value',          Filter::ByKeyValue
    register 'r/filter/by_key_value_presence', Filter::ByKeyValuePresence
    register 'r/filter/inactive',              Filter::Inactive

    register 'r/format/date',                  Format::Date
    register 'r/format/lowercase',             Format::Lowercase
    register 'r/format/remove_whitespace',     Format::RemoveWhitespace
    register 'r/format/string_replace',        Format::StringReplace
    register 'r/format/string_template',       Format::StringTemplate
    register 'r/format/substring',             Format::Substring
    register 'r/format/uppercase',             Format::Uppercase

    register 'r/logical/switch',               Logical::Switch

    register 'r/type/boolean',                 Type::Boolean
    register 'r/type/string',                  Type::String

    register 'r/value/blank',                  Value::Blank
    register 'r/value/map',                    Value::Map
    register 'r/value/now',                    Value::Now
    register 'r/value/null',                   Value::Null
    register 'r/value/resolve',                Value::Resolve
    register 'r/value/static',                 Value::Static
    register 'r/value/uuid',                   Value::Uuid
    register 'r/value/verbatim', '',           Value::Verbatim
  end
end
