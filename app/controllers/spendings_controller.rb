class SpendingsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new transaction_params
    @transaction.user = current_user
    if @transaction.save
      redirect_to
    else
      render
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def index
    @spendings = Transaction.all
  end

  def destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount_cents,
                                        :transaction_date,
                                        :description)
  end
end
