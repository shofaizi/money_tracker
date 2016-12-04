class SpendingsController < ApplicationController
  before_action :authenticate_user

  def new
    @spending = Transaction.new
    @user = current_user
  end

  def create
    @user = current_user
    @spending = Transaction.new transaction_params
    @spending.user = current_user
    if @spending.save
      redirect_to spendings_path, notice: "Created new Spendings"
    else
      render :new
    end
  end

  def edit
    @spending = Transaction.find params[:id]
  end

  def show
  end

  def update
    @spending = Transaction.find params[:id]
    @spending.user = current_user
    if @spending.user.update transaction_params
      flash[:notice] = "Spending updated"
      render :edit
    end
  end

  def index
    @spendings = Transaction.where(is_spending: true).where(user: current_user).order(created_at: :desc).limit(5)
  end

  def destroy
    spending = Transaction.find params[:id]
    spending.destroy
    flash[:notice]= 'Spending deleted'
    redirect_to spendings_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount_cents,
                                        :transaction_date,
                                        :description)
  end
end
