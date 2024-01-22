json.extract! congviec, :id, :macongviec, :noidung, :ngay_bd, :ngay_kt, :status, :vanban_id, :created_at, :updated_at
json.url congviec_url(congviec, format: :json)
json.noidung congviec.noidung.to_s
