class PagesController < ApplicationController
  def home
    if request.fullpath == '/'
      @category = Category.new(name: 'root').decorate
      @children = Category.where(parent_id: nil)
      @resources = []
      @bootstrap_json = render_to_string(
        template: 'api/categories/show.json.jbuilder'
      )
      response.content_type = 'text/html'
    end
  end
end
