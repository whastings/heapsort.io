class BookmarksController < ApplicationController

  include AuthenticationHelper
  include AuthorizationHelper

  # Filters:
  before_filter :restrict_to_signed_in, only: [:new, :create]

  def index
    @bookmarks = Bookmark.paginate(page: params[:page])
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = current_user.bookmarks.build
  end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      flash[:success] = 'Bookmark added!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def bookmark_params
      params.require(:bookmark).permit(:title, :url, :description)
    end

end
