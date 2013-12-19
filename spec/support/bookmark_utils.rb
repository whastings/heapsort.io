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
