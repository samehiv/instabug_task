module V1
  class ChatsController < ApiController
    before_action :set_application
    before_action :set_chat, only: %i[show]

    def index
      chats = @application.chats
      @data = Pagination.serialize(chats, params[:page], params[:per_page])
    end

    def show; end

    def create
      chat_number = RedisServer.next_chat_number(@application.id)
      CreateChatJob.perform_later(@application, chat_number)

      render_json(200, data: { chat_number: chat_number })
    end

    private

    def set_chat
      @chat = @application.chats.find_by!(number: params[:number])
    end

    def set_application
      @application = Application.find_by!(token: params[:application_token])
    end
    
  end
end