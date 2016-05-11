json.array!(@admin_cms_pages) do |admin_cms_page|
  json.extract! admin_cms_page, :id
  json.url admin_cms_page_url(admin_cms_page, format: :json)
end
