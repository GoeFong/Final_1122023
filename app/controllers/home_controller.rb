class HomeController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_notifications, only: :index,  if: :current_user
  def index
    
  end

  def thongkecongviec

    render partial: 'home/thongke'
  end

  def thongkecongviec2
    if params[:start_date_between].present?
      starts = params[:start_date_between].split(" - ").first.to_date
      ends = params[:start_date_between].split(" - ").last.to_date
      @kq = ActiveRecord::Base.connection.exec_query("
        SELECT COUNT(a.id) AS TONGSL ,b.label as trangthai , c.name
        FROM Congviecs a, Lcongviec_trangthais b, boards c
        where a.lcongviec_trangthai_id = b.id
        AND a.board_id = c.id
        AND a.created_at >=  '#{starts}'  AND a.created_at <=  '#{ends}'
        GROUP BY b.id,c.id
        
      ")
      @board = []
      @kq.each do |kq|
        unless @board.include?(kq['name'])
          @board << kq['name']
        end
      end

    else
    @board = Board.all

    @kq = ActiveRecord::Base.connection.exec_query("
      SELECT COUNT(a.id) AS TONGSL ,b.label ,c.name
      FROM Congviecs a, Lcongviec_trangthais b, boards c
      where a.lcongviec_trangthai_id = b.id
      AND a.board_id = c.id
      GROUP BY b.id
      
    ")
    end

    render partial: 'home/thongke2', locals:{ kq: @kq,board:@board}
  end
  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user).newest_first.limit(9)
    @unread = @notifications.unread
    @read = @notifications.read
  end
end
