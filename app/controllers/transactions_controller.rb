class TransactionsController < ApplicationController
  before_action :authenticate_user

  def index
    @transactions = Transaction.where(user: current_user).order(transaction_date: :desc)
  end

  def overview
    @date_end       = Date.today.end_of_month
    @date_beginning = Date.today.beginning_of_month
    @transactions   = Transaction.all.where(user: current_user).where(transaction_date: Date.today-30..Date.today)
  end

  def overview_ajax
    expenses = 0
    income = 0
    date =
      if params[:begin].present?
        params[:begin]
      elsif params[:end].present?
        params[:end]
      end

    date_beginning = DateTime.parse(date).to_date
    if params[:begin].present?
      date_beginning = DateTime.parse(date).to_date
      date_start = (date_beginning - 30).strftime('%Y-%-m-%-d')
      date_end   = date_beginning.strftime('%Y-%-m-%-d')
    elsif params[:end].present?
      date_beginning = DateTime.parse(date).to_date
      date_start = date_beginning.strftime('%Y-%-m-%-d')
      date_end   = (date_beginning + 30).strftime('%Y-%-m-%-d')
      p date_end
    end

    # date_end = date_beginning.strftime('%Y-%-m-%-d')
    @transactions = Transaction.all.where(user: current_user).where(transaction_date: date_beginning-30..date_beginning)
    @transactions.each do |txn|
      if txn.is_spending?
        expenses += txn.amount_cents
      else
        income   += txn.amount_cents
      end
    end
    budget_left = income - expenses
    data = {
      transactions: @transactions,
      expenses: expenses/100,
      income: income/100,
      budget_left: budget_left/100,
      date_beginning: date_start,
      date_end: date_end
    }
    render json: (data)
  end

  def new_spending
    @transaction = Transaction.new
    @user = current_user
  end

  def new_credit
    @transaction = Transaction.new
  end

  def new_debit
    @transaction = Transaction.new
  end

  def create
    @user = current_user
    @transaction = Transaction.new transaction_params
    @transaction.user = current_user
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to root_path, notice: "Created new Spendings" }
        format.json { render json: { result: 'ok' }, status: :created, location: @transaction }
      else
        format.html { render(@transaction.is_spending ? :new_debit : :new_credit) }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
        # error_path = @transaction.is_spending ? :new_debit : :new_credit
        # render error_path
      end
    end
  end

  def edit
    @transaction = Transaction.find params[:id]
  end

  def update
    @transaction = Transaction.find params[:id]
    @transaction.user = current_user

    respond_to do |format|
      if @transaction.user.update transaction_params
        format.html { redirect_to @transaction, notice: "Transaction updated" }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def spending_index
    @transaction = Transaction.where(is_spending: true).where(user: current_user).order(created_at: :desc).limit(5)
  end

  def destroy
    transaction = Transaction.find params[:id]
    transaction.destroy

    respond_to do |format|
      format.js { render :delete_success }
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount,
                                        :transaction_type,
                                        :transaction_date,
                                        :description,
                                        :is_spending,
                                        :budget_ids => [])
  end
end
