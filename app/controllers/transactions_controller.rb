class TransactionsController < ApplicationController
  before_action :authenticate_user

  def show

  end

  def index
    @transaction = Transaction.where(user: current_user)
  end

  def overview
    @transaction = Transaction.new
  end

end
