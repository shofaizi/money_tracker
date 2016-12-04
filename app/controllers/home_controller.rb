class HomeController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    home_params = params.require(:transaction).permit(:description, :amount_cents)
    @transaction = Transaction home_params
    @transaction.user = current_user
    if @transaction.save
      redirect_to root_path
    end
  end

end
