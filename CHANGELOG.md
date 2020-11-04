# 1.3.0 (November 4th, 2020)

New Transformers:

* r/format/string_template
* r/format/substring

# 1.2.0 (October 6th, 2020)

New Transformers:

* r/type/boolean
* r/type/string
* r/value/now
* r/value/uuid

# 1.1.1 (September 9th, 2020)

Fixes:

* Do not leverage #to_datetime even if it is available for date parsing.  This removes un-intentional coupling of other libraries into Realize and keeps it based on Ruby standard and core libraries.

# 1.1.0 (June 24th, 2020)

Addition of r/collection/at_index, r/collection/first, and r/collection/last

# 1.0.0 (June 9th, 2020)

Initial Release, includes 15 initial transformers.
