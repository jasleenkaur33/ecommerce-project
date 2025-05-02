module OrdersHelper
  # Helper Method for Status Badge Class
  def status_badge_class(status)
    case status
    when "pending" then "bg-warning text-dark"
    when "completed" then "bg-success"
    when "cancelled" then "bg-danger"
    else "bg-secondary"
    end
  end

  end
  