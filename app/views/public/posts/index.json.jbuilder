json.data do
  json.items do
    json.array!(@posts) do |post|
      json.id post.id
      json.user do
        json.name post.user.name
        json.profile_image url_for(post.user.profile_image)
      end
      json.image url_for(post.image)
      json.post_title post.post_title
      json.post_text post.post_text
      json.address post.address
      json.latitude post.latitude
      json.longitude post.longitude
    end  
  end
end