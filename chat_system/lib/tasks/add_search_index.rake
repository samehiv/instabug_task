namespace :search do
  desc 'create elasticsearch index and import data'
  task :add_index, [:model] => :environment do |_task, args|
    model = args.model.constantize
    model.__elasticsearch__.create_index!
    model.import
  rescue StandardError => e
    puts e.message + ' automatic retry in 15 sec'
    sleep(15)
    retry
  end
end
