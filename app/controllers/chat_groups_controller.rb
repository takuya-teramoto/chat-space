class ChatGroupsController < ApplicationController
  before_action :set_chat_group, only: [:show, :edit, :update, :destroy]
  before_action :confirm_current_user, only: [:edit, :update, :destroy]


  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.new(chat_group_params)
    if @chat_group.save
      redirect_to chat_group_chats_path(@chat_group), notice: 'グループを作成しました'
    else
      render :new, alert: 'グループを作成できませんでした'
    end
  end

  def edit
  end

  def update
    if @chat_group.update(chat_group_params)
      redirect_to chat_group_chats_path(@chat_group), notice: 'グループ情報を更新しました'
    else
      render :edit, alert: 'グループ情報を更新できませんでした'
    end
  end

  def index
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.json
    end
  end

  private
  def set_chat_group
    @chat_group = ChatGroup.find(params[:id])
  end

  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids: [])
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
