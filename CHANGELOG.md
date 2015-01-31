0.5.0 (January 31, 2015)

* Add generator for locales file
* Add breadcrumbs scope for translations
* Change breadcrumb formatter to use translations for title formatting
* Add ability to pass proc as title and/or url for breadcrumb helper inside controller

0.4.0 (January 10, 2015)

* Change breadcrumbs view method to return enumerator without block
* Change Crumb to ruby class and add force option
* Change Configuration to ruby class and scope config options
* Add ability to force current path through :force option
* Change format_name to only take name argument
* Change to expose config settings on configuration
* Fix bug with url parameter to allow for regular rails path variables
* Update test suite to work against different rubies 1.9.x, 2.x
* Test Rails 3.2.x, 4.0, 4.1, 4.2

0.3.0 (February 25, 2012)

* Add loaf gem errors
* Add custom options validator for filtering invalid breadcrumbs params
* Renamed main gem helpers for adding breadcrumbs from `add_breadcrumb` to
  `breadcrumb`, both inside controllers and views.
* Add specs for isolated view testing.

0.2.1 (February 22, 2012)

* Add more integration tests and fixed bug with adding breadcrumbs inside view
* Add specs for controller extensions

0.2.0 (February 18, 2012)

* Change gemspec with new gem dependencies, use git
* Setup testing environment with dummy rails app
* Add integration tests for breadcrumbs view rendering
* Add translation module for breadcrumbs title lookup
* Add breadcrumb formatting module with tests
* Refactor names for controller and view extensions
