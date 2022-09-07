# Haunted

This gem will allow you to pull data from a Ghost CMS installation through its content API.

You can read more about the Ghost CMS here:
https://ghost.org/

...and more about its content API here:
https://ghost.org/docs/content-api/

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add haunted

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install haunted

## Usage

### Creating a Ghost Content API Key
Using the gem is pretty simple.

All you need is the url of your Ghost CMS site and a content API key.

You can generate a content API key by going to your Ghost admin area and then Settings > Integrations.

Once there you click "Add custom integration" to create a new key.

## Haunted Gem Quick Start

### Initializing the API client
    
    api = Haunted::GhostContentApi.new('https://my-ghost-cms-site.com', '{CONTENT_API_KEY}')

### Responses
All of this gem's methods return the HTTParty response directly.

See https://rubygems.org/gems/httparty

### Getting All Resources
There are methods to get all items for a specified type (posts, authors, tags, pages).

For example, if you want to get all posts you would.
    
    posts = api.posts

By default results are returned in pages of 15 items, but you use the paging parameter to specify the number of items
per page and also the page number.

For example, if you wanted to get all posts in a single call this would do it:
    
    all_posts_for_real = api.posts(paging: { limit: :all })

You can also use limit with page to specify the page of results to return, this would return the second page of 
results in pages of 5:
    
    page_of_posts = api.posts(paging: { limit: '5', page: '2' })

### Getting Resource by ID
If you need to get a single resource by its ID then you can use the find by id methods (posts_by_id, authors_by_id, 
tags_by_id, pages_by_id).

For example, if you want to get a post by its id:

    post = api.posts_by_id("6260c376eb848005f39bf06e")

### Getting Resource by Slug
Getting resources by their slug is the same as by getting them by ID. There are a set of methods (posts_by_slug, 
authors_by_slug, tags_by_slug, pages_by_slug) for that.

For example, if you want to get a post by its slug:

    post = apt.posts_by_slug("my-cool-post")

## Including Related Resources
All methods have an include parameter to specify related resources to return. An example of this would be a post's
author. 

You can include the author resource for a post along with it like this:

    posts_with_author = api.posts(include: [:author])

## Limiting Returned Fields
If you don't need all of a resource's field you can specify when ones you need using the fields parameter. All methods
accept this parameter.

Say you wanted to only return a post's id, title, and slug.

You would do it like this:

    posts_with_only_certain_fields = api.posts(fields: [:id, :title, :slug])

## Further Reading
For more details on the Ghost CMS content API please take a look at the official documentation:

https://ghost.org/docs/content-api/

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DanaHolt/haunted.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
