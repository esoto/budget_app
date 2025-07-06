class BudgetsController < ApplicationController
  before_action :set_budget, only: [ :show, :edit, :update, :destroy ]

  def index
    @budgets = Budget.by_date.all
    @current_budget = Budget.active.first || Budget.by_date.last
  end

  def show
  end

  def new
    @budget = Budget.new
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @budget = Budget.new(budget_params)
    respond_to do |format|
      if @budget.save
        @budgets = Budget.by_date.all
        @current_budget = Budget.active.first || Budget.by_date.last
        format.html { redirect_to budgets_path, notice: "Budget was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Budget created successfully!" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    respond_to do |format|
      if @budget.update(budget_params)
        @budgets = Budget.by_date.all
        @current_budget = Budget.active.first || Budget.by_date.last
        format.html { redirect_to budgets_path, notice: "Budget was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Budget updated successfully!" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @budget.destroy
    @budgets = Budget.by_date.all
    @current_budget = Budget.active.first || Budget.by_date.last
    respond_to do |format|
      format.html { redirect_to budgets_path, notice: "Budget was successfully deleted." }
      format.turbo_stream { flash.now[:notice] = "Budget deleted successfully!" }
    end
  end

  private

  def set_budget
    @budget = Budget.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:name, :start_date, :end_date, :total_amount)
  end
end
