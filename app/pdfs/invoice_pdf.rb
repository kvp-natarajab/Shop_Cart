class InvoicePdf < Prawn::Document
 require 'prawn/table'
 def initialize(orderdetail, user, order, view)
    super()
    @orderdetail = orderdetail
    @user = user
    @order = order
    @view = view
    text "RETAIL INVOICE",:indent_paragraphs => 220, :size => 15
    subscription_date
    thanks_message
    regards_message
    table_content
  end

  def thanks_message
  	move_down 20
    text "Hello #{@user.name.capitalize},"
    move_down 10
    text "Thank you for your order.Print this receipt as confirmation of your order.",
    :indent_paragraphs => 40, :size => 13
  end

  def subscription_date
  	text "INVOICE NUMBER :#{@order.ordernumber}"
    move_down 20
    text "INVOICE DATE : #{Time.now.strftime("%d/%m/%Y")}", :size => 12
    
  end

  def user_info
  	table([
  		['Name:#{@user.name}']
  	])
  end


  def table_content
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [40, 200, 40, 100, 100]
    end
  end

  def product_rows
    [['#', 'ITEM DESCRIPTION', 'QTY', 'RATE', 'AMOUNT']] +
      @orderdetail.map do |product|
      [product.id, product.product_name, product.quantity, product.unit_price]
    end
  end

  def regards_message
    move_down 50
    text "Thank You," ,:indent_paragraphs => 400
    move_down 6
    text "XYZ",
    :indent_paragraphs => 370, :size => 14, style:  :bold
  end
end