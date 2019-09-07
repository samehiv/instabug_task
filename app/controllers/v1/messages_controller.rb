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
      body = params.require(:body)
      number = RedisServer.next_message_number(@chat)
      CreateMessageJob.perform_later(@chat, number, body)

      render_json(200, data: { message_number: number })
    end

    private

    def set_message
      @message = @chat.messages.find_by!(number: params[:number])
    end
    
    def set_chat
      @chat = @application.chats.find_by!(number: params[:chat_number])
    end

    def set_application
      @application = Application.find_by!(token: params[:application_token])
    end

    
    
  end
end