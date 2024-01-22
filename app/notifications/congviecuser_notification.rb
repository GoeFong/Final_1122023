# To deliver this notification:
#
# CongviecuserNotification.with(post: @post).deliver_later(current_user)
# CongviecuserNotification.with(post: @post).deliver(current_user)

class CongviecuserNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    @congviec = Congviec.find(params[:congviec][:id])
    # @board = Board.find(params[:congviec][:board_id])
    @user = User.find(params[:congviecuser][:user_id])
    "Có công việc #{@congviec.macongviec} vừa nhận"
  end
  #
  def url
    @congviec = Congviec.find(params[:congviec][:id])
    if @congviec.board.present?
      board_congviec_path(params[:congviec][:board_id], params[:congviec][:id])
    else
    show_congviec_url(params[:congviec][:id])

    end
  end
end
