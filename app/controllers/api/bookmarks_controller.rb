
class Api::BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.paginate(page: params[:page]).decorate
    render "bookmarks/index"
  end
end

