module WebDevBookmarks
  module Spec
    module ResourceUtils

      def resource_created?(resource)
        Resource.where(
          domain: resource.domain,
          path: resource.path,
          query_string: resource.query_string
        ).any?
      end

    end
  end
end

RSpec::Matchers.define(:show_resource) do |resource|
  match do |page|
    expect(page).to have_link(resource.title, resource.slug)
    expect(page).to have_link(resource.url)
    expect(page).to have_content(resource.user.username)
  end
end

RSpec::Matchers.define(:show_full_resource) do |resource|
  match do |page|
    expect(page).to have_selector('h1', text: resource.title)
    expect(page).to have_link(resource.url)
    expect(page).to have_content(resource.user.username)
    expect(page).to have_content(resource.description)
  end
end
