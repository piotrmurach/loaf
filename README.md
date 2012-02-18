# Loaf [![Build Status](https://secure.travis-ci.org/peter-murach/loaf.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/peter-murach/loaf.png?travis)][gemnasium]

[travis]: http://travis-ci.org/peter-murach/loaf
[gemnasium]: https://gemnasium.com/peter-murach/loaf

Breadcrumbs creation library.

* Helps in creating breadcrumbs.
* Uses controllers to specify names and routes for parts of breadcrum trails or collections of breadcrumbs.
* Stays out of your way when it comes to markup exposing only single helper method to access breadcrumb data.

## Installation

Install from source:

```ruby
gem install loaf
```

Add to your Gemfile:

```ruby
gem 'loaf'
```

## Configuration

There is a small set of custom opinionated defaults. However, to override them in your views just pass an option hash. The following options are valid:

```ruby
:crumb_length  # integer, default length is 30 characters
:root          # boolean, default is true, displays the home crumb
```

## Usage

In controller:

```ruby
class Blog::CategoriesController < ApplicationController

  add_breadcrumb 'Article Categories', 'blog_categories_path', :only => [:show]

  def show
    add_breadcrumb "#{@category.title}", 'blog_category_path(@category)'
  end
end
```

You can add breadcrumbs for nested resources, for instance, article categories:

You can add semantic markup in your view to show breadcrumbs

```html
<ul id="breadcrumbs">
  <%- breadcrumbs :crumb_length => 20 do |name, url, styles| -%>
    <li class="<%= styles %>">
      <%= link_to name, url %>
      <span><%= styles == 'selected' ? '' : '::' %></span>
    </li>
  <%- end -%>
</ul>
```

## TODO

* Add ability to add breadcrumbs for nested resources
* Add support for name internationalisation
* Finish specs

## Contributing to loaf

Questions or problems? Please post them on the [issue tracker](https://github.com/peter-murach/loaf/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `bundle` and `rake`.

## Copyright

Copyright (c) 2011 Piotr Murach. See LICENSE.txt for
further details.
