# Loaf [![Build Status](https://secure.travis-ci.org/peter-murach/loaf.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/peter-murach/loaf.png?travis)][gemnasium]

[travis]: http://travis-ci.org/peter-murach/loaf
[gemnasium]: https://gemnasium.com/peter-murach/loaf

Breadcrumbs creation library.

* Helps in creating breadcrumbs.
* Uses controllers to specify names and routes for parts of breadcrum trails or collections of breadcrumbs.
* Stays out of your way when it comes to markup exposing only single helper method to access breadcrumb data.
* Supports Rails 2 & 3.

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

There is a small set of custom opinionated defaults. The following options are valid parameters:

```ruby
:crumb_length  # breadcrumb length in integer, default length is 30 characters
:root          # boolean, default is true, displays the home crumb
:capitalize    # set breadcrumbs to have initial letter uppercase, default false
:style_classes # CSS class to be used to style current breadcrumb,
               # defaults to 'selected'
```

You can override them in your views by passing them to the view `breadcrumb` helper

```ruby
<% breadcrumbs :crumb_length => 20 do |name, url, styles| %>
  ..
<% end %>
```

or by adding initializer

```ruby
Loaf.configure do |config|
  config.crumb_length => 20
end
```

## Usage

In controller:

```ruby
class Blog::CategoriesController < ApplicationController

  breadcrumb 'Article Categories', 'blog_categories_path', :only => [:show]

  def show
    breadcrumb "#{@category.title}", 'blog_category_path(@category)'
  end
end
```

You can add breadcrumbs for nested resources, for instance, article categories:

In your view add semantic markup to show breadcrumbs:

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

Usually best practice is to put such snippet inside its own partial.

## Locale

When adding breadcrumbs one can use locales for their titles. The only assumption it makes is that all breadcrumb names are scoped inside `breadcrumbs` namespace. However, this can be easily changed by passing `:scope => 'new_scope_name'` configuration option

```ruby
en:
  breadcrumbs:
    controller:
      action:
```

Therefore in your controller/view one would have

```ruby
class Blog::CategoriesController < ApplicationController

  breadcrumb 'blog.categories', 'blog_categories_path'

end

And corresponding entry in locale:

en:
  breadcrumbs:
    blog:
      categories: 'Article Categories'
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
