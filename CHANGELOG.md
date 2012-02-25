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
