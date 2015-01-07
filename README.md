# Loaf
[![Gem Version](https://badge.fury.io/rb/loaf.png)][gem]
[![Build Status](https://secure.travis-ci.org/peter-murach/loaf.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/peter-murach/loaf.png)][codeclimate]
[![Dependency Status](https://gemnasium.com/peter-murach/loaf.png?travis)][gemnasium]
[![Coverage Status](https://coveralls.io/repos/peter-murach/loaf/badge.png?branch=master)][coveralls]
[![Inline docs](http://inch-ci.org/github/peter-murach/loaf.png?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/loaf
[travis]: http://travis-ci.org/peter-murach/loaf
[codeclimate]: https://codeclimate.com/github/peter-murach/loaf
[gemnasium]: https://gemnasium.com/peter-murach/loaf
[coveralls]: https://coveralls.io/r/peter-murach/loaf
[inchpages]: http://inch-ci.org/github/peter-murach/loaf

> **Loaf** manages and displays breadcrumb trails in your Rails application.

## Features

* Uses controllers or views to specify breadcrumb trails
* No markup assumptions for breadcrumbs rendering
* Use locales file for names - optional
* Supports Rails 2.x, 3.x, 4.0, 4.1, 4.2

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'loaf'
```

And then execute:

```ruby
$ bundle
```

Or install it yourself as:

```ruby
gem install loaf
```

## 1. Usage

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

## 2. Configuration

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

## 3. Locale

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

## Contributing

Questions or problems? Please post them on the [issue tracker](https://github.com/peter-murach/loaf/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `bundle` and `rake`.

## Copyright

Copyright (c) 2011-2015 Piotr Murach. See LICENSE.txt for further details.
