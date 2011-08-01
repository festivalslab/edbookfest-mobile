module BookHelper
  def availability(status = "none")
    case status
    when "available"
      text = "This book is <strong>available</strong>"
    when "limited"
      text = "This book has <strong>limited availability</strong>"
    else
      status = "none"
      text = "This book is currently <strong>out of stock</strong>"
    end
    "<p class=\"availability #{status}\">#{text}</p>"
  end
end