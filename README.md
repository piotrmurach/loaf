<div align="center">
  <img width="237" src="https://github.com/piotrmurach/loaf/blob/master/assets/loaf_logo.png" alt="Loaf gem logo" />
</div>

# Loaf

[![Gem Version](https://badge.fury.io/rb/loaf.svg)][gem]
[![Actions CI](https://github.com/piotrmurach/loaf/workflows/CI/badge.svg?branch=master)][gh_actions_ci]
[![Maintainability](https://api.codeclimate.com/v1/badges/966193dafa3895766977/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/loaf/badge.svg?branch=master)][coveralls]
[![Inline docs](http://inch-ci.org/github/piotrmurach/loaf.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/loaf
[gh_actions_ci]: https://github.com/piotrmurach/loaf/actions?query=workflow%3ACI
[codeclimate]: https://codeclimate.com/github/piotrmurach/loaf/maintainability
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
gem "loaf"
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
    * [2.1.3 :match](#213-match)
    * [2.1.4 :http_verbs](#214-http_verbs)
  * [2.2 breadcrumb_trail](#22-breadcrumb_trail)
* [3. Configuration](#3-configuration)
* [4. Translation](#4-translation)

## 1. Usage

**Loaf** allows you to add breadcrumbs in controllers and views.

In order to add breadcrumbs in controller use `breadcrumb` method ([see 2.1](#21-breadcrumb)).

```ruby
class Blog::CategoriesController < ApplicationController

  breadcrumb "Article Categories", :blog_categories_path, only: [:show]

  def show
    breadcrumb @category.title, blog_category_path(@category)
  end
end
```

Then in your view render the breadcrumbs trail using [breadcrumb_trail](#22-breadcrumb_trail)

## 2. API

### 2.1 breadcrumb

Creation of breadcrumb in Rails is achieved by the `breadcrumb` helper.

The `breadcrumb` method takes at minimum two arguments: the first is a name for the crumb that will be displayed and the second is a url that the name points to. The url parameter uses the familiar Rails conventions.

When using path variable `blog_categories_path`:

```ruby
breadcrumb "Categories", blog_categories_path
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
breadcrumb @category.title, {controller: "categories", action: "show", id: @category.id}
```

#### 2.1.1 controller

Breadcrumbs are inherited, so if you set a breadcrumb in `ApplicationController`, it will be inserted as a first element inside every breadcrumb trail. It is customary to set root breadcrumb like so:

```ruby
class ApplicationController < ActionController::Base
  breadcrumb "Home", :root_path
end
```

Outside of controller actions the `breadcrumb` helper behaviour is similar to filters/actions and as such you can limit breadcrumb scope with familiar options `:only`, `:except`. Any breadcrumb specified inside actions creates another level in breadcrumbs trail.

```ruby
class ArticlesController < ApplicationController
  breadcrumb "All Articles", :articles_path, only: [:new, :create]
end
```

Each time you call the `breadcrumb` helper, a new element is added to a breadcrumb trial stack:

```ruby
class ArticlesController < ApplicationController
  breadcrumb "Home", :root_path
  breadcrumb "All Articles", :articles_path

  def show
    breadcrumb "Article One", article_path(:one)
    breadcrumb "Article Two", article_path(:two)
  end
end
```

**Loaf** allows you to call controller instance methods inside the `breadcrumb` helper outside of any action. This is useful if your breadcrumb has parameterized behaviour. For example, to dynamically evaluate parameters for breadcrumb title do:

```ruby
class CommentsController < ApplicationController
  breadcrumb -> { find_article(params[:post_id]).title }, :articles_path
end
```

Also, to dynamically evaluate parameters inside the url argument do:

```ruby
class CommentsController < ApplicationController
  breadcrumb "All Comments", -> { post_comments_path(params[:post_id]) }
end
```

You may wish to define breadcrumbs over a collection. This is easy within views, and controller actions (just loop your collection), but if you want to do this in the controller class you can use the `before_action` approach:

```ruby
before_action do
  ancestors.each do |ancestor|
    breadcrumb ancestor.name, [:admin, ancestor]
  end
end
```

Assume `ancestors` method is defined inside the controller.

#### 2.1.2 view

**Loaf** adds `breadcrumb` helper also to the views. Together with controller breadcrumbs, the view breadcrumbs are appended as the last in breadcrumb trail. For instance, to specify view breadcrumb do:

```ruby
<% breadcrumb @category.title, blog_category_path(@category) %>
```

#### 2.1.3 :match

**Loaf** allows you to define matching conditions in order to make a breadcrumb current with the `:match` option.

The `:match` key accepts the following values:

* `:inclusive` - the default value, which matches nested paths
* `:exact` - matches only the exact same path
* `:exclusive` - matches only direct path and its query parameters if present
* `/regex/` - matches based on regular expression
* `{foo: bar}` - match based on query parameters

For example, to force a breadcrumb to be the current regardless do:

```ruby
breadcrumb "New Post", new_post_path, match: :exact
```

To make a breadcrumb current based on the query parameters do:

```ruby
breadcrumb "Posts", posts_path(order: :desc), match: {order: :desc}
```

#### 2.1.4 :http_verbs

**Loaf** allows you to match on multiple HTTP verbs in order to make a breadcrumb current with the `:http_verbs` option.

The `:http_verbs` key accepts `:all` or an array with following values:

* `:get`
* `:post`
* `:put`
* `:patch`
* `:delete`
* `:head`

Its default value is `[:get]`

For example:

```ruby
http_verbs: %w[get head]
http_verbs: %w[post get head]
http_verbs: :all
```

### 2.2 breadcrumb_trail

In order to display breadcrumbs use the `breadcrumb_trail` view helper. It accepts optional argument of configuration options and can be used in two ways.

One way, given a block it will yield all the breadcrumbs in order of definition:

```ruby
breadcrumb_trail do |crumb|
  ...
end
```

The yielded parameter is an instance of `Loaf::Crumb` object with the following methods:

```ruby
crumb.name     # => the name as string
crumb.path     # => the path as string
crumb.url      # => alias for path
crumb.current? # => true or false
```

For example, you can add the following semantic markup to show breadcrumbs using the `breadcrumb_trail` helper like so:

```erb
<nav aria-label="breadcrumb">
  <ol class="breadcrumbs">
    <% breadcrumb_trail do |crumb| %>
      <li class="<%= crumb.current? ? "current" : "" %>">
        <%= link_to crumb.name, crumb.url, (crumb.current? ? {"aria-current" => "page"} : {}) %>
        <% unless crumb.current? %><span>::</span><% end %>
      </li>
    <% end %>
  </ol>
</nav>
```

For Bootstrap 4:

```erb
<% #erb %>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <% breadcrumb_trail do |crumb| %>
      <li class="breadcrumb-item <%= crumb.current? ? "active" : "" %>">
        <%= link_to_unless crumb.current?, crumb.name, crumb.url, (crumb.current? ? {"aria-current" => "page"} : {}) %>
      </li>
    <% end %>
  </ol>
</nav>
```

And, if you are using `HAML` do:

```haml
  - # haml
  %ol.breadcrumb
    - breadcrumb_trail do |crumb|
      %li.breadcrumb-item{class: crumb.current? ? "active" : "" }
        = link_to_unless crumb.current?, crumb.name, crumb.url, (crumb.current? ? {"aria-current" => "page"} : {})
```

Usually best practice is to put such snippet inside its own `_breadcrumbs.html.erb` partial.

The second way is to use the `breadcrumb_trail` without passing a block. In this case, the helper will return an enumerator that you can use to, for example, access an array of names pushed into the breadcrumb trail in order of addition. This can be handy for generating page titles from breadcrumb data.

For example, you can define a `breadcrumbs_to_title` method in `ApplicationHelper` like so:

```ruby
module ApplicationHelper
  def breadcrumbs_to_title
    breadcrumb_trail.map(&:name).join(">")
  end
end
```

Use whichever of the two ways is more convenient given your application structure and needs.

## 3. Configuration

There is a small set of custom opinionated defaults. The following options are valid parameters:

```ruby
:match # set match type, default :inclusive (see [:match](#213-match) for more details)
```

You can override them in your views by passing them to the view `breadcrumb` helper

```erb
<% breadcrumb_trail(match: :exclusive) do |name, url, styles| %>
  ..
<% end %>
```

or by configuring an option in `config/initializers/loaf.rb`:

```ruby
Loaf.configure do |config|
  config.match = :exclusive
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

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Loaf project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/loaf/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2011 Piotr Murach. See LICENSE.txt for further details.
