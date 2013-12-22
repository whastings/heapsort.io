RSpec::Matchers.define(:have_title_tag) do |title|
  match do |page|
    expect(page).to have_title(title)
  end
end

RSpec::Matchers.define(:have_heading) do |title|
  match do |page|
    expect(page).to have_selector('h1', text: title)
  end
end

RSpec::Matchers.define(:have_page_title) do |title|
  match do |page|
    expect(page).to have_title_tag(title)
    expect(page).to have_heading(title)
  end
end

RSpec::Matchers.define(:have_success_message) do |message|
  match do |page|
    expect(page).to have_selector('.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define(:have_error_message) do |message|
  match do |page|
    expect(page).to have_selector('.alert.alert-danger', text: message)
  end
end

RSpec::Matchers.define(:have_error_list) do
  match do |page|
    expect(page).to have_selector('.error-messages ul > li')
  end
end

RSpec::Matchers.define(:have_pagination) do
  match do |page|
    expect(page).to have_selector('div.pagination')
  end
end
