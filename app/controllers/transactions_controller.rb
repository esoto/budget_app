class TransactionsController < ApplicationController
  before_action :set_transaction, only: [ :show, :edit, :update, :destroy ]
  before_action :set_current_budget, only: [ :index, :new, :create ]

  def index
    @transactions = @current_budget&.transactions&.includes(:category)&.recent || Transaction.none
    @pagy, @transactions = pagy(@transactions, items: 20) if defined?(Pagy)
  end

  def show
  end

  def new
    @transaction = Transaction.new
    @transaction.budget = @current_budget
    @transaction.date = Date.current
    @categories = Category.all.by_name
    @budgets = Budget.by_date

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @categories = Category.all.by_name
    @budgets = Budget.by_date

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path, notice: "Transaction was successfully created." }
        format.turbo_stream {
          flash.now[:notice] = "Transaction added successfully!"
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @categories = Category.all.by_name
    @budgets = Budget.by_date

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    @categories = Category.all.by_name
    @budgets = Budget.by_date

    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transactions_path, notice: "Transaction was successfully updated." }
        format.turbo_stream {
          flash.now[:notice] = "Transaction updated successfully!"
        }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_path, notice: "Transaction was successfully deleted." }
      format.turbo_stream {
        flash.now[:notice] = "Transaction deleted successfully!"
      }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_current_budget
    @current_budget = Budget.active.first || Budget.by_date.last
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :date, :budget_id, :category_id)
  end
end
