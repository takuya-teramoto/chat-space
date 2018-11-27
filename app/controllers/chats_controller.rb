class ChatsController < ApplicationController
  def index
    respond_to do |format|
      format.html{
        if params[:chat_group_id]
          @chat = Chat.new
          @chat_group = ChatGroup.find(params[:chat_group_id])
          @chats = @chat_group.chats.order(id: "DESC").includes(:user)
        end
        @chat_groups = ChatGroup.order(id: "DESC").includes(:chats)
      }
      format.json{
        @newest_chats = Chat.where(chat_group_id: params[:chat_group_id]).where('id > ?', params[:chat_id]).includes(:user)
      }
    end
  end

  def create
    @chat = Chat.new(chat_params)
    @chat_group = ChatGroup.find(params[:chat_group_id])
    @chats = @chat_group.chats.order(id: "DESC").includes(:user)
    if @chat.save
      render :create
    else
      redirect_to chat_group_chats_path(@chat.chat_group), alert: '投稿できませんでした'
    end
  end

  private
    def chat_params
      params.require(:chat).permit(:text, :image).merge(user_id: current_user.id, chat_group_id: params[:chat_group_id])
    end
end
