# frozen_string_literal: true

require_relative "haunted/version"
require "httparty"

module Haunted
  ##
  # Client that communicates with the Ghost CMS content API
  class GhostContentApi
    include HTTParty

    ##
    # Initializes a new Ghost Content API client
    #
    # site_url: URL to the Ghost site
    # key: Content API key
    # options: api_path - override the default content API path, api_version - override the default API version
    def initialize(site_url, key, **options)
      @site_url = site_url
      @key = key
      @api_path = options[:api_path] || "ghost/api/content"
      @api_version = options[:api_version] || "v5.0"
    end

    %w[posts authors tags pages].each do |resource_type|
      ##
      # Methods that get all posts, authors, tags, or pages. By default all items are returned with all
      # properties in pages of 15 results each.
      #
      # include: Array of strings or symbols that specify additional related resource types to include, for example
      # include[:tags] would include a post's tags.
      #
      # fields: Array of strings or symbols that specify which resource fields are returned. If you only need some
      # fields then use this option.
      #
      # Available options for the include and fields options vary depending on the resource, see the Ghost Content API
      # for more information.
      #
      # paging: Hash that specifies paging and limit options. Use { limit: all } to return all items. Specify a number
      # to returned that number of items per page. Use { page: x } to specify what page of results to return.
      #
      define_method(resource_type) do |include: nil, fields: nil, paging: nil|
        response = self.class.get(
          build_browse_api_endpoint(resource_type),
          query: build_query_string_params(@key, include, fields, paging: paging),
          headers: build_headers
        )

        response
      end
    end

    %w[posts_by_id authors_by_id tags_by_id pages_by_id].each do |method|
      resource_type = method.split("_").first

      ##
      # These methods (posts_by_id authors_by_id tags_by_id pages_by_id) get posts, authors, tags, or pages by
      # the resource's id.
      #
      # id: id of the item you want to return
      #
      # include: Array of strings or symbols that specify additional related resource types to include, for example
      # include[:tags] would include a post's tags.
      #
      # fields: Array of strings or symbols that specify which resource fields are returned. If you only need some
      # fields then use this option.
      #
      # Available options for the include and fields options vary depending on the resource, see the Ghost Content API
      # for more information.
      define_method(method) do |id, include: nil, fields: nil|
        response = self.class.get(
          build_id_api_endpoint(resource_type, id),
          query: build_query_string_params(@key, include, fields),
          headers: build_headers
        )

        response
      end
    end

    %w[posts_by_slug authors_by_slug tags_by_slug pages_by_slug].each do |method|
      resource_type = method.split("_").first

      ##
      # These methods (posts_by_slug authors_by_slug tags_by_slug pages_by_slug )get posts, authors, tags, or pages by
      # the resource's slug.
      #
      # slug: slug of the item you want to return
      #
      # include: Array of strings or symbols that specify additional related resource types to include, for example
      # include[:tags] would include a post's tags.
      #
      # fields: Array of strings or symbols that specify which resource fields are returned. If you only need some
      # fields then use this option.
      #
      # Available options for the include and fields options vary depending on the resource, see the Ghost Content API
      # for more information.
      define_method(method) do |slug, include: nil, fields: nil|
        response = self.class.get(
          build_slug_api_endpoint(resource_type, slug),
          query: build_query_string_params(@key, include, fields),
          headers: build_headers
        )

        response
      end
    end

    private

    def build_browse_api_endpoint(type)
      "#{@site_url}/#{@api_path}/#{type}"
    end

    def build_id_api_endpoint(type, id)
      "#{build_browse_api_endpoint(type)}/#{id}"
    end

    def build_slug_api_endpoint(type, slug)
      "#{build_browse_api_endpoint(type)}/slug/#{slug}"
    end

    def build_query_string_params(key, include, fields, paging: nil)
      params = { key: key }

      params[:include] = include.join(",") unless include.nil? || include.empty?
      params[:fields] = fields.join(",") unless fields.nil? || fields.empty?
      params[:limit] = paging[:limit] unless paging.nil? || paging[:limit].nil? || paging[:limit].empty?
      params[:page] = paging[:page] unless paging.nil? || paging[:page].nil? || paging[:page].empty?

      params
    end

    def build_headers
      { 'Accept-Version': @api_version }
    end
  end
end
