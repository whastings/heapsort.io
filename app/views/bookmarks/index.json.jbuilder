json.array!(@bookmarks) do |bookmark|
  json.partial!('bookmarks/bookmark', bookmark: bookmark)
end
