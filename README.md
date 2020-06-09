# Motivation

This repository helps reproducing a breaking change between rails `5.2.3` and `5.2.4` regarding validation of associations.

# Models

There are two models here: `Book` and `Page`. 
`Book` has two contextual validations, `on: :review` and `on: :publish`, the last one going over the associated `pages` and running another validation (`on: :color_page`) on it.


# Steps to reproduce the issue

First, we have to see how it goes in rails `5.2.3` by opening a console and running:

```ruby
b = Book.create
p = Page.create(book: b)
b.valid?(:publish) # false
b.pages.first.errors.messages # {:rgb=>["can't be blank"]}
b.valid?(:review) # true
b.pages.first.errors.messages # {:rgb=>["can't be blank"]}
```

Here, the second validation does not reset the associated model errors.

Then, upgrade to rails `5.2.4` by changing the `Gemfile` and running `bundle update rails`. Let's have a look at the same piece of code as before with this rails version:

```ruby
b = Book.create
p = Page.create(book: b)
b.valid?(:publish) # false
b.pages.first.errors.messages # {:rgb=>["can't be blank"]}
b.valid?(:review) # true
b.pages.first.errors.messages # {}
```

It now resets the associated model errors!

This is not mentioned in the [release notes of `5.2.4`](https://github.com/rails/rails/releases/tag/v5.2.4).
