class CustomerInvoicesController < ApplicationController
  before_action :set_customer_invoice, only: [:show, :edit, :update, :destroy]
  #before_action :set_cost_center, only: [:create, :new]
  #before_action :set_sales, only: [:create, :new]

  # GET /customer_invoices
  # GET /customer_invoices.json
  def index
    @customer_invoices = CustomerInvoice.all
  end

  # GET /customer_invoices/1
  # GET /customer_invoices/1.json
  def show
  end

  # GET /customer_invoices/new
  def new
    @customer_invoice = CustomerInvoice.new
    @cost_center = CostCenter.find(params[:cost_center_id])
  end

  # GET /customer_invoices/1/edit
  def edit
  end

  # POST /customer_invoices
  # POST /customer_invoices.json
  def create
    @customer_invoice = CustomerInvoice.new(customer_invoice_params)

    respond_to do |format|
      if @customer_invoice.save
        format.html { redirect_to cost_center_path(@customer_invoice.cost_center_id), notice: 'Customer invoice was successfully created.' }
        format.json { render :show, status: :created, location: @customer_invoice }
        format.js
      else
        format.html { render :new }
        format.json { render json: @customer_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_invoices/1
  # PATCH/PUT /customer_invoices/1.json
  def update
    respond_to do |format|
      if @customer_invoice.update(customer_invoice_params)
        format.html { redirect_to cost_center_path(@customer_invoice.cost_center_id), notice: 'Customer invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer_invoice }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @customer_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_invoices/1
  # DELETE /customer_invoices/1.json
  def destroy
    cost_center_id = @customer_invoice.cost_center_id
    @customer_invoice.destroy
    respond_to do |format|
      format.html { redirect_to cost_center_path(cost_center_id), notice: 'Customer invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_invoice
      @customer_invoice = CustomerInvoice.find(params[:id])
    end

    def set_cost_center
      @cost_center = CostCenter.find(params[:id])
    end

    def set_sales
      @sales_order = SalesOrder.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_invoice_params
      params.require(:customer_invoice).permit(:cost_center_id, :sales_order_id, :invoice_value, :invoice_date, :delivery_certificate_file, :delivery_certificate_state, :reception_report_file, :reception_report_state, :invoice_state)
    end
end
