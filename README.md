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
* Specify urls using Rails conventions
* No markup assumptions for breadcrumbs rendering
* Use locales file for names - optional
* Tested with Rails 3.2, 4.0, 4.1, 4.2

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

**Loaf** allows you to add breadcrumbs in controllers and views.

In order to add breadcrumbs in controller use `breadcrumb` method ([see 1.1](#11-breadcrumb)). Outside of controller actions the `breadcrumb` helper behaviour is similar to filters and as such you can limit breadcrumb scope with familiar options `:only`, `:except`. Any breadcrumb specified inside actions creates another level in breadcrumbs trail.

```ruby
class Blog::CategoriesController < ApplicationController

  breadcrumb 'Article Categories', :blog_categories_path, only: [:show]

  def show
    breadcrumb "#{@category.title}", blog_category_path(@category)
  end
end
```

**Loaf** adds `breadcrumb` helper also to the views. Together with controller breadcrumbs, the view breadcrumbs are appended as the last. For instance, to specify view breadcrumb do:

```ruby
<% breadcrumb "#{@category.title}", blog_category_path(@category) %>
```

Finally, in your view layout add semantic markup to show breadcrumbs:

```html
<ul class='breadcrumbs'>
  <% breadcrumbs do |name, url, styles| %>
    <li class="<%= styles %>">
      <%= link_to name, url %>
      <span><%= styles == 'selected' ? '' : '::' %></span>
    </li>
  <% end %>
</ul>
```

Usually best practice is to put such snippet inside its own partial.

### 1.1 breadcrumb

Creation of breadcrumb in Rails is achieved by the `breadcrumb` helper. The `breadcrumb` method takes at minimum two arguments: the first is a name for the crumb that will be displayed and the second is a url that the name points to. The url parameter uses the familiar Rails conventions.

When using path variable `blog_categories_path`:

```ruby
breadcrumb 'Categories', blog_categories_path
```

When using an instance `@category`:

```ruby
breadcrumb "#{@category.title}", blog_category_path(@category)

```
You can also use set of objects:

```ruby
breadcrumb "#{@category.title}, [:blog, @category]"
```

You can specify segments of the url:

```ruby
breadcrumb "#{@category.title}", {controller: 'categories', action: 'show', id: @category.id}
```

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
<% breadcrumbs crumb_length: 20 do |name, url, styles| %>
  ..
<% end %>
```

or by adding initializer in `config/initializers/loaf.rb`:

```ruby
Loaf.configure do |config|
  config.crumb_length = 20
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
