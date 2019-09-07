namespace :search do
  desc 'create elasticsearch index and import data'
  task :add_search_index, [:model] => :environment do |_task, args|
    model = args.model.constantize
    model.__elasticsearch__.create_index!
    model.import
  end
end
