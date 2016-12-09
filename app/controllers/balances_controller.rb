class BalancesController < ApplicationController

  def index
    @name = 'Balance'
    @data   = [yesterday_txns, today_txns, tmrw_txns]
    @labels = ["Yesterday", "Today", "Tomorrow"]
    respond_to do |format|
      format.js {}
    end
  end

  private

  def yesterday_txns
    Transaction.balance(current_user,Date.today-1)
  end

  def today_txns
    Transaction.balance(current_user,Date.today)
  end

  def tmrw_txns
    Transaction.balance(current_user,Date.today+1)
  end

end
