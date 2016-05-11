json.array!(@admin_feedbacks) do |admin_feedback|
  json.extract! admin_feedback, :id, :category_id, :feedback, :account_id, :status
  json.url admin_feedback_url(admin_feedback, format: :json)
end
