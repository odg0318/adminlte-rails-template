module Admin
  class UsersController < Admin::ApplicationController
    include Pundit

    respond_to :json, :html
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /users
    # GET /users.json
    def index
      @users = User.all
    end

    # GET /users/1
    # GET /users/1.json
    def show
      @roles = Role.all
    end

    # GET /users/new
    def new
      @user = User.new
      @url = admin_users_path
      @roles = Role.all
    end

    # GET /users/1/edit
    def edit
      @url = admin_user_path(@user)
      @roles = Role.all
    end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = t('admin.users.create.success')
        respond_with :edit, :admin, @user
      else
        flash[:warning] = @user.errors.full_messages.uniq.join(', ')
        respond_with :new, :admin, :user
      end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      if update_user 
        flash[:notice] = t('admin.users.update.success')
        respond_with :edit, :admin, @user
      else
        flash[:warning] = @user.errors.full_messages.uniq.join(', ')
        respond_with :edit, :admin, :user
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: t('admin.users.destroy.success') }
        format.json { head :no_content }
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    private def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    private def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :role_id)
    end

    private def update_user
      if user_params[:password].blank?
        @user.update_without_password(user_params)
      else
        @user.update(user_params)
      end
    end
  end
end
