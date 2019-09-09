namespace :search do
  desc 'create elasticsearch index and import data'
  task :add_index, [:model] => :environment do |_task, args|
    model = args.model.constantize
    model.__elasticsearch__.create_index!
    model.import
    puts "elasticsearch connection done successfully and #{args.model} index created"
  rescue StandardError => e
    puts e.message + ' automatic retry in 10 sec'
    sleep(10)
    retry
  end
  
end
