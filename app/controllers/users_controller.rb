class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy update_mail update_password update_name]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  def get_by_mail
    if params[:email].present?
      @user = User.find_by(user_mail: params[:email])
      if @user
        render json: @user
      else
        render json: { error: "Usuario no encontrado" }, status: :not_found
      end
    else
      render json: { error: "No ingreso parametro de email" }, status: :bad_request
    end
  end

  def update_mail
    if params[:email].present?
      if @user.update(user_mail: params[:email])
        render json: @user, notice: "El correo ha sido modificado con exito"
      else
        render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    else
      render json: { error: "No ingreso parametro de email" }, status: :bad_request
    end
  end

  def update_password
    if params[:current_password].present? && params[:new_password].present?
      if @user.user_password == params[:current_password]
        if @user.update(user_password: params[:new_password])
          render json: { message: "Se ha actualizado la contrasena" }, status: :ok
        else
          render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
      else
        render json: { error: "Contrasena incorrecta" }, status: :unauthorized
      end
    else
      render json: { error: "Se necesita que ingrese contrasena actual y la nueva contrasena" }, status: :bad_request
    end
  end

  def update_name
    if params[:name].present?
      if @user.update(user_name: params[:name])
        render json: @user, notice: "El nombre se ha actualizado correctamente"
      else
        render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    else
      render json: { error: "Se requiere el paramero nombre" }, status: :bad_request
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:user_name, :user_mail, :user_password, :is_admin)
    end
end
