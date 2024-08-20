class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @post = Post.new # アプリの都合上定義しておりますご自身のアプリに合わせて変更して下さい。
    @groups = Group.all
  end

  def show
    @post = Post.new # アプリの都合上定義しておりますご自身のアプリに合わせて変更して下さい。
    @group = Group.find(params[:id])
  end
  
  def join #追記！
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to  groups_path
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params) # 修正: group_paramsを使用して@groupを初期化
    @group.owner_id = current_user.id # 誰が作ったグループかを判断するために必要
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
#current_userは、@group.usersから消されるという記述。
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
