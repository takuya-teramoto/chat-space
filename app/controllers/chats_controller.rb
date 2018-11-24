class ChatsController < ApplicationController
  # before_action :set_chat, only: [:show, :edit, :update, :destroy]
  # before_action :confirm_current_user, only: [:edit, :update, :destroy]
  # GET /chats
  # GET /chats.json
  def index
    if params[:chat_group_id] #rootは除外する
      @chat = Chat.new
      @chat_group = ChatGroup.find(params[:chat_group_id])
      @chats = @chat_group.chats.order(id: "DESC")
    end
    @chat_groups = ChatGroup.all.includes(:chats, :users)
  end

  # GET /chats/1
  # GET /chats/1.json
  # def show
  # end

  # GET /chats/new
  # def new
  #   @chat = Chat.new
  # end

  # GET /chats/1/edit
  # def edit
  # end

  # POST /chats
  # POST /chats.json
  def create
    @chat = Chat.new(chat_params)
    @chats = Chat.all.order(id: "DESC").includes(:user)
    if @chat.save
      render :create
    else
      redirect_to chat_group_chats_path(@chat.chat_group), alert: '投稿できませんでした'
    end
  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  # def update
  #   respond_to do |format|
  #     if @chat.update(chat_params)
  #       format.html { redirect_to @chat, notice: 'Chat was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @chat }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @chat.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /chats/1
  # DELETE /chats/1.json
  # def destroy
  #   @chat.destroy
  #   respond_to do |format|
  #     format.html { redirect_to chats_url, notice: 'Chat was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def chat_params
      params.require(:chat).permit(:text, :image).merge(user_id: current_user.id, chat_group_id: params[:chat_group_id])
    end

    # def confirm_current_user
    #   redirect_to action: :index unless current_user.id == @chat.user.id
    # end
end
