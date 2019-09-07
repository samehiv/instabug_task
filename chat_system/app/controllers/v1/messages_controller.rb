module V1
  class MessagesController < ApiController
    before_action :set_application
    before_action :set_chat
    before_action :set_message, only: %i[show update destroy]

    def index
      messages = if params[:keyword].present?
                   Message.search(Message.search_query(@chat, params[:keyword]))
                 else
                   @chat.messages
                 end
      @data = Pagination.serialize(messages, params[:page], params[:per_page])
    end

    def show; end

    def create
      body = params.require(:body)
      number = RedisServer.next_message_number(@chat)
      CreateMessageJob.perform_later(@chat, number, body)

      render_json(200, data: { message_number: number })
    end

    def update
      body = params.require(:body)
      UpdateMessageJob.perform_later(@message, body)

      render_json(200)
    end

    def destroy
      DestroyMessageJob.perform_later(@message)

      render_json(200)
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
