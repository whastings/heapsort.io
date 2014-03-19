# A script for importing my Firefox bookmarks.

require 'json'

def find_folder(name, contents)
  name = name.split('/') unless name.is_a?(Array)
  current_folder, found_folder, children = name.first, nil, contents
  name = name.drop(1)
  children.each do |child|
    if child[:type] == 'text/x-moz-place-container' && child[:title] == current_folder
      found_folder = child
      break
    end
  end
  return find_folder(name, found_folder[:children]) if (name.length > 0 && found_folder)
  found_folder
end

def create_resource(bookmark, category)
  Resource.create!(
    title: bookmark[:title],
    url: bookmark[:uri],
    user_id: 1,
    category_id: category.id
  )
end

def create_category(folder, parent_folder)
  Category.create!(name: folder[:title], parent_id: parent_folder.try(:id))
end

def parse_contents(folder, parent_folder = nil, skip_new = false)
  new_category = nil
  new_category = create_category(folder, parent_folder) unless skip_new
  folder[:children].each do |child|
    if child[:type] == 'text/x-moz-place'
      create_resource(child, new_category)
    elsif child[:type] == 'text/x-moz-place-container'
      parse_contents(child, new_category)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  json = JSON.parse(File.read(ARGV[0]), symbolize_names: true)
  start_folder = find_folder('Bookmarks Menu/Web Dev', json[:children])
  begin
    parse_contents(start_folder, nil, true)
  rescue ActiveRecord::RecordInvalid => error
    p error.record
    raise error
  end
end
