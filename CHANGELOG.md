# Changelog

## 0.8.0

 * Fix .district_of when sector belongs to multiple districts (#2)

## 0.7.2

 * Add Coveralls and Travis CI
 * Remove pretence at support for 1.9.3 (gem depends on to_h for Struct)

## 0.7.1

 * Fix error in Location calling exist? instead of valid? and update tests

## 0.7.0

 * Add .valid? because the Rails interface needs to accept an empty location as being "like" an .exist?ing one

## 0.6.0

 * Addition of Location class (moved out of rails app)
 * Separation of rails components in separate gem
 * Conversion to singleton to reduce load times in some circumstances
 * Improved test environment (catching up with code)

## 0.5.2
 * Fix serious bug in .where_is? that gave incorrect information

## 0.5.0
 * Add .where_is? to enable fast general queries of the dataset
 * allow .exists? as a synonym of .exist?

## 0.4.0
 * Add case-insensitivity to all division lookups (#1)
 * Add translation of province names between English and Kinyarwanda

## 0.3.3
 * Fix relative path error
 
## 0.3.1
 * Include cells and villages using data from MINALOC

## 0.1.0
 * First release, covering only provinces, districts and sectors (data unavailable for cells and villages)
