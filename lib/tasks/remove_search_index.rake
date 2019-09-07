namespace :search do
  desc 'remove elasticsearch index'
  task :remove_index, [:model] => :environment do |_task, args|
    model = args.model.constantize
    model.__elasticsearch__.delete_index!
  end
end
