# frozen_string_literal: true

RSpec.describe Haunted do
  let(:test_domain) { "haunted-gem-test.com" }
  let(:api_base_path) { "#{test_domain}/ghost/api/content" }
  let(:client_site_url) { "http://#{test_domain}" }
  let(:key) { "abc123" }

  it "has a version number" do
    expect(Haunted::VERSION).not_to be nil
  end

  it "can retrieve all posts" do
    first_post_id = "p4gkxdr76r"

    posts = fixture("posts/multiple_posts.json")

    stub_request(:get, "#{api_base_path}/posts?key=#{key}")
      .to_return(body: posts.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.posts)

    expect(result["posts"].length).to eq(3)
    expect(result["posts"][0]["id"]).to eq(first_post_id)
  end

  it "can retrieve post by post id" do
    post_id = "vl8jmc8org"
    post_slug = "xshcbt60oy"

    posts = fixture("posts/single_post_id.json")

    stub_request(:get, "#{api_base_path}/posts/#{post_id}?key=#{key}")
      .to_return(body: posts.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.posts_by_id(post_id))

    expect(result["posts"].length).to eq(1)
    expect(result["posts"][0]["id"]).to eq(post_id)
    expect(result["posts"][0]["slug"]).to eq(post_slug)
  end

  it "can retrieve post by post slug" do
    post_id = "x6al4454yg"
    post_slug = "dykpjna05h"

    posts = fixture("posts/single_post_slug.json")

    stub_request(:get, "#{api_base_path}/posts/slug/#{post_slug}?key=#{key}")
      .to_return(body: posts.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.posts_by_slug(post_slug))

    expect(result["posts"].length).to eq(1)
    expect(result["posts"][0]["id"]).to eq(post_id)
    expect(result["posts"][0]["slug"]).to eq(post_slug)
  end

  it "can retrieve all tags" do
    first_tag_id = "v2x6gc0910"

    tags = fixture("tags/multiple_tags.json")

    stub_request(:get, "#{api_base_path}/tags?key=#{key}")
      .to_return(body: tags.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.tags)

    expect(result["tags"].length).to eq(4)
    expect(result["tags"][0]["id"]).to eq(first_tag_id)
  end

  it "can retrieve tag by tag id" do
    tag_id = "9ikbvm4dqt"
    tag_slug = "8az86kpgc0"

    tags = fixture("tags/single_tag_id.json")

    stub_request(:get, "#{api_base_path}/tags/#{tag_id}?key=#{key}")
      .to_return(body: tags.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.tags_by_id(tag_id))

    expect(result["tags"].length).to eq(1)
    expect(result["tags"][0]["id"]).to eq(tag_id)
    expect(result["tags"][0]["slug"]).to eq(tag_slug)
  end

  it "can retrieve tag by tag slug" do
    tag_id = "0hu7rc7hkt"
    tag_slug = "6tekwl0h36"

    tags = fixture("tags/single_tag_slug.json")

    stub_request(:get, "#{api_base_path}/tags/slug/#{tag_slug}?key=#{key}")
      .to_return(body: tags.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.tags_by_slug(tag_slug))

    expect(result["tags"].length).to eq(1)
    expect(result["tags"][0]["id"]).to eq(tag_id)
    expect(result["tags"][0]["slug"]).to eq(tag_slug)
  end

  it "can retrieve all authors" do
    first_author_id = "xn7h5mkyyt"

    authors = fixture("authors/multiple_authors.json")

    stub_request(:get, "#{api_base_path}/authors?key=#{key}")
      .to_return(body: authors.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.authors)

    expect(result["authors"].length).to eq(5)
    expect(result["authors"][0]["id"]).to eq(first_author_id)
  end

  it "can retrieve author by author id" do
    author_id = "s9rbcyjcld"
    author_slug = "qclrisffbj"

    authors = fixture("authors/single_author_id.json")

    stub_request(:get, "#{api_base_path}/authors/#{author_id}?key=#{key}")
      .to_return(body: authors.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.authors_by_id(author_id))

    expect(result["authors"].length).to eq(1)
    expect(result["authors"][0]["id"]).to eq(author_id)
    expect(result["authors"][0]["slug"]).to eq(author_slug)
  end

  it "can retrieve author by author slug" do
    author_id = "7xw26s3cp7"
    author_slug = "7q95dh3g6u"

    authors = fixture("authors/single_author_slug.json")

    stub_request(:get, "#{api_base_path}/authors/slug/#{author_slug}?key=#{key}")
      .to_return(body: authors.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.authors_by_slug(author_slug))

    expect(result["authors"].length).to eq(1)
    expect(result["authors"][0]["id"]).to eq(author_id)
    expect(result["authors"][0]["slug"]).to eq(author_slug)
  end

  it "can retrieve all pages" do
    first_page_id = "0oeqbvwnj5"

    pages = fixture("pages/multiple_pages.json")

    stub_request(:get, "#{api_base_path}/pages?key=#{key}")
      .to_return(body: pages.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.pages)

    expect(result["pages"].length).to eq(6)
    expect(result["pages"][0]["id"]).to eq(first_page_id)
  end

  it "can retrieve page by page id" do
    page_id = "llnsb1vxes"
    page_slug = "m44aps0p2v"

    pages = fixture("pages/single_page_id.json")

    stub_request(:get, "#{api_base_path}/pages/#{page_id}?key=#{key}")
      .to_return(body: pages.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.pages_by_id(page_id))

    expect(result["pages"].length).to eq(1)
    expect(result["pages"][0]["id"]).to eq(page_id)
    expect(result["pages"][0]["slug"]).to eq(page_slug)
  end

  it "can retrieve page by page slug" do
    page_id = "xob9liupt3"
    page_slug = "e12b27kbew"

    pages = fixture("pages/single_page_slug.json")

    stub_request(:get, "#{api_base_path}/pages/slug/#{page_slug}?key=#{key}")
      .to_return(body: pages.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.pages_by_slug(page_slug))

    expect(result["pages"].length).to eq(1)
    expect(result["pages"][0]["id"]).to eq(page_id)
    expect(result["pages"][0]["slug"]).to eq(page_slug)
  end

  it "can retrieve tiers" do
    tier_id = "8192cs934t8ta00128t"
    tier_slug = "free"

    tiers = fixture("tiers.json")

    stub_request(:get, "#{api_base_path}/tiers?key=#{key}")
      .to_return(body: tiers.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.tiers)

    expect(result["tiers"].length).to eq(1)
    expect(result["tiers"][0]["id"]).to eq(tier_id)
    expect(result["tiers"][0]["slug"]).to eq(tier_slug)
  end

  it "can retrieve settings" do
    title = "Ghost"
    logo = "https://docs.ghost.io/content/images/2014/09/Ghost-Transparent-for-DARK-BG.png"
    url = "https://docs.ghost.io/"

    settings = fixture("settings.json")

    stub_request(:get, "#{api_base_path}/settings?key=#{key}")
      .to_return(body: settings.read, status: 200)

    api = Haunted::GhostContentApi.new(client_site_url, key)

    result = JSON.parse(api.settings)

    expect(result["settings"]["title"]).to eq(title)
    expect(result["settings"]["logo"]).to eq(logo)
    expect(result["settings"]["url"]).to eq(url)
  end
end
