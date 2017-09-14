<div align="center">
  <img width="237" src="https://cdn.rawgit.com/piotrmurach/loaf/master/assets/loaf_logo.png" alt="loaf logo" />
</div>

# Loaf

[![Gem Version](https://badge.fury.io/rb/loaf.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/loaf.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/piotrmurach/loaf/badges/gpa.svg)][codeclimate]
[![Dependency Status](https://gemnasium.com/piotrmurach/loaf.svg?travis)][gemnasium]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/loaf/badge.svg?branch=master)][coveralls]
[![Inline docs](http://inch-ci.org/github/piotrmurach/loaf.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/loaf
[travis]: http://travis-ci.org/piotrmurach/loaf
[codeclimate]: https://codeclimate.com/github/piotrmurach/loaf
[gemnasium]: https://gemnasium.com/piotrmurach/loaf
[coveralls]: https://coveralls.io/github/piotrmurach/loaf
[inchpages]: http://inch-ci.org/github/piotrmurach/loaf

> **Loaf** manages and displays breadcrumb trails in your Rails application.

## Features

* Use controllers and/or views to specify breadcrumb trails
* Specify urls using Rails conventions
* No markup assumptions for breadcrumbs trails rendering
* Use locales file for breadcrumb names
* Tested with Rails `>= 3.2` and Ruby `>= 2.0.0`

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

Then run the generator:

```ruby
rails generate loaf:install
```

## Contents

* [1. Usage](#1-usage)
* [2. API](#2-api)
  * [2.1 breadcrumb](#21-breadcrumb)
    * [2.1.1 controller](#211-controller)
    * [2.1.2 view](#212-view)
    * [2.1.3 :force](#213-force)
  * [2.2 breadcrumbs_trail](#22-breadcrumbs-trail)
* [3. Configuration](#3-configuration)
* [4. Translation](#4-translation)

## 1. Usage

**Loaf** allows you to add breadcrumbs in controllers and views.

In order to add breadcrumbs in controller use `breadcrumb` method ([see 2.1](#21-breadcrumb)).

```ruby
class Blog::CategoriesController < ApplicationController

  breadcrumb 'Article Categories', :blog_categories_path, only: [:show]

  def show
    breadcrumb @category.title, blog_category_path(@category)
  end
end
```

Then in your view render the breadcrumbs trail using [breadcrumbs_trail](#22-breadcrumbs-trail)

## 2. API

### 2.1 breadcrumb

Creation of breadcrumb in Rails is achieved by the `breadcrumb` helper.

The `breadcrumb` method takes at minimum two arguments: the first is a name for the crumb that will be displayed and the second is a url that the name points to. The url parameter uses the familiar Rails conventions.

When using path variable `blog_categories_path`:

```ruby
breadcrumb 'Categories', blog_categories_path
```

When using an instance `@category`:

```ruby
breadcrumb @category.title, blog_category_path(@category)
```

You can also use set of objects:

```ruby
breadcrumb @category.title, [:blog, @category]
```

You can specify segments of the url:

```ruby
breadcrumb @category.title, {controller: 'categories', action: 'show', id: @category.id}
```

#### 2.1.1 controller

Breadcrumbs are inherited, so if you set a breadcrumb in `ApplicationController`, it will be inserted as a first element inside every breadcrumb trail. It is customary to set root breadcrumb like so:

```ruby
class ApplicationController < ActionController::Base
  breadcrumb 'Home', :root_path
end
```

Outside of controller actions the `breadcrumb` helper behaviour is similar to filters/actions and as such you can limit breadcrumb scope with familiar options `:only`, `:except`. Any breadcrumb specified inside actions creates another level in breadcrumbs trail.

```ruby
class ArticlesController < ApplicationController
  breadcrumb 'All Articles', :articles_path, only: [:new, :create]
end
```

**Loaf** allows you to call controller instance methods inside the `breadcrumb` helper outside of any action. This is useful if your breadcrumb has parameterized behaviour. For example, to dynamically evaluate parameters for breadcrumb title do:

```ruby
class CommentsController < ApplicationController
  breadcrumb ->(c) { c.find_article(c.params[:post_id]).title }, :articles_path
end
```

Also, to dynamically evalute parameters inside the url argument do:

```ruby
class CommentsController < ApplicationController
  breadcrumb 'All Comments', ->(c) { c.post_comments_path(c.params[:post_id]) }
end
```

#### 2.1.2 view

**Loaf** adds `breadcrumb` helper also to the views. Together with controller breadcrumbs, the view breadcrumbs are appended as the last in breadcrumb trail. For instance, to specify view breadcrumb do:

```ruby
<% breadcrumb @category.title, blog_category_path(@category) %>
```

#### 2.1.3 :force

**Loaf** allows you to force a breadcrumb to be current.

For example, on the create action as you are likely want the breadcrumb to be similar as for new action.

```ruby
class PostsController < ApplicationController
  def create
    breadcrumb 'New Post', new_post_path, force: true
    render action: :new
  end
end
```

### 2.2 breadcrumbs_trail

In your view layout add semantic markup to show breadcrumbs using the `breadcrumbs_trail` like so:

```html
<ul id='breadcrumbs'>
  <% breadcrumbs_trail do |name, url, styles| %>
    <li class="<%= styles %>">
      <%= link_to name, url %>
      <% unless styles.include?('selected') %><span>::</span><% end %>
    </li>
  <% end %>
</ul>
```

Usually best practice is to put such snippet inside its own partial.

## 3. Configuration

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

## 4. Translation

You can use locales files for breadcrumbs' titles. **Loaf** assumes that all breadcrumb names are scoped inside `breadcrumbs` namespace inside `loaf` scope. However, this can be easily changed by passing `scope: 'new_scope_name'` configuration option.

```ruby
en:
  loaf:
    breadcrumbs:
      name: 'my-breadcrumb-name'
```

Therefore, in your controller/view you would do:

```ruby
class Blog::CategoriesController < ApplicationController
  breadcrumb 'blog.categories', :blog_categories_path
end
```

And corresponding entry in locale would be:

```ruby
en:
  loaf:
    breadcrumbs:
      blog:
        categories: 'Article Categories'
```

## Contributing

Questions or problems? Please post them on the [issue tracker](https://github.com/piotrmurach/loaf/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `bundle` and `rake`.

## Copyright

Copyright (c) 2011-2017 Piotr Murach. See LICENSE.txt for further details.
