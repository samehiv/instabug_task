# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Message.destroy_all
Application.delete_all
Chat.delete_all


FactoryBot.create_list :application, 10
FactoryBot.create_list :chat, 10, application: Application.first
FactoryBot.create_list :message, 10, chat: Chat.first

Application.first.update(chats_count: Application.first.chats.count)
Chat.first.update(messages_count: Chat.first.messages.count)
