class BookmarksController < ApplicationController
  include AuthenticationHelper

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      render text: 'success', status: 200
    else
      render text: 'failure', status: 400
    end
  end

  private

    def bookmark_params
      params.require(:bookmark).permit(:title, :url, :description)
    end

end
