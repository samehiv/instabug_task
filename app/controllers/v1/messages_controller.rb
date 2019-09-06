module V1
  class MessagesController < ApiController
    before_action :set_application
    before_action :set_chat
    before_action :set_message, only: %i[show]

    def index
      @data = Pagination.serialize(@chat.messages, params[:page], params[:per_page])
    end

    def show; end

    def create
      message_number = RedisServer.next_message_number(@chat)
      CreateChatJob.perform_later(@application, chat_number)

      render_json(200, data: { message_number: message_number })
    end

    private

    def message_params
      params.permit(:body)
    end

    def set_message
      @message = @chats.messages.find_by!(number: params[:number])
    end
    
    def set_chat
      @chat = @application.chats.find_by!(number: params[:chat_number])
    end

    def set_application
      @application = Application.find_by!(token: params[:application_token])
    end

    
    
  end
end