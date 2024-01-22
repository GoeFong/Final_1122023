json.extract! vanban, :id, :link_to_apply, :title, :level, :ghichu, :user_id, :created_at, :updated_at
json.url vanban_url(vanban, format: :json)
json.ghichu vanban.ghichu.to_s
