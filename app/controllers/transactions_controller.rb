class TransactionsController < ApplicationController
  before_action :authenticate_user

  def index
    @transactions = Transaction.where(user: current_user)
  end

  def overview
    @transaction = Transaction.all.where(user: current_user)
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
        # flash[:notice] = "Updated"
        # render :edit
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
      format.html { redirect_to transactions_url, notice: "Transaction deleted" }
      format.json { head :no_content}
    # flash[:notice]= 'Transaction deleted'
    # redirect_to transactions_path
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount_cents,
                                        :transaction_type,
                                        :transaction_date,
                                        :description,
                                        :is_spending,
                                        :budget_ids => [])
  end
end
