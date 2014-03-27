namespace :heapsort do
  desc "Reset friendly Ids for a given class"
  task reset_friendly_ids: :environment do
    model_class = ARGV.last
    task model_class.to_sym do ; end # Keep rake from trying to execute as task.
    model_class = model_class.constantize
    model_class.all.each do |instance|
      instance.slug = nil
      instance.save!
    end
  end

end
