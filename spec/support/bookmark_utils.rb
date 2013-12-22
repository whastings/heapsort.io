module WebDevBookmarks
  module Spec
    module BookmarkUtils

      def bookmark_created?(bookmark)
        Bookmark.where(
          domain: bookmark.domain,
          path: bookmark.path,
          query_string: bookmark.query_string
        ).any?
      end

    end
  end
end

RSpec::Matchers.define(:show_bookmark) do |bookmark|
  match do |page|
    expect(page).to have_link(bookmark.title, bookmark.slug)
    expect(page).to have_link(bookmark.url)
    expect(page).to have_content(bookmark.user.username)
  end
end

RSpec::Matchers.define(:show_full_bookmark) do |bookmark|
  match do |page|
    expect(page).to have_selector('h1', text: bookmark.title)
    expect(page).to have_link(bookmark.url)
    expect(page).to have_content(bookmark.user.username)
    expect(page).to have_content(bookmark.description)
  end
end
