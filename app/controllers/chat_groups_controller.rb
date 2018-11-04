class ChatGroupsController < ApplicationController
before_action :set_chat_group, only: [:show, :edit, :update, :destroy]
before_action :confirm_current_user, only: [:edit, :update, :destroy]


  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.new(chat_group_params)
    respond_to do |format|
      if @chat_group.save
        @user_chat_group = UserChatGroup.new(user_id: current_user.id, chat_group_id: @chat_group.id)
        @user_chat_group.save
        format.html { redirect_to chat_group_chats_path(@chat_group), notice: 'グループを作成しました' }
        format.json { render :show, status: :created, location: @chat_group }
      else
        format.html { render :new, alert: 'グループを作成できませんでした' }
        format.json { render json: @chat_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @chat_group.update(chat_group_params)
        format.html { redirect_to chat_group_chats_path(@chat_group), notice: 'グループ情報を更新しました' }
        format.json { render :show, status: :ok, location: @chat_group }
      else
        format.html { render :edit, alert: 'グループ情報を更新できませんでした' }
        format.json { render json: @chat_group.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_chat_group
    @chat_group = ChatGroup.find(params[:id])
  end

  def chat_group_params
    params.require(:chat_group).permit(:name)
  end

  def confirm_current_user
    redirect_to chat_group_chats_path(@chat_group) unless authenticate_user?(@chat_group)
  end

  def authenticate_user?(chat_group)
    judge = false
    chat_group.user_ids.each do |id|
      if id == current_user.id
        judge =  true
      end
    end
    return judge
  end
end
