class PhotosController < ApplicationController

def index

  matching_photos = Photo.all

  @list_of_photos = matching_photos.order ({ :created_at => :desc })


  render({ :template => "photo_templates/index"})
end

def show
  # Parameters: {"path_id"=>"777"}
  url_id = params.fetch("path_id")
  matching_photos = Photo.where ({ :id => url_id })
  @the_photo = matching_photos.at(0)
  render({ :template => "photo_templates/show"})
end

def bye
# Parameters: {"toast_id"=>"777"}

  the_id = params.fetch("toast_id")

  matching_photos = Photo.where({ :id => the_id })

  the_photo = matching_photos.at(0)

  the_photo.destroy

  redirect_to("/photos")
end

def create
# {"query_image"=>"", "query_caption"=>"", "query_owner_id"=>""}

input_image = params.fetch("query_image")
input_caption = params.fetch("query_caption")
input_owner_id = params.fetch("query_owner_id")

a_new_photo = Photo.new

a_new_photo.image = input_image
a_new_photo.caption = input_caption
a_new_photo.owner_id = input_owner_id

a_new_photo.save

redirect_to("/photos/" + a_new_photo.id.to_s)
  #render({ :template => "photo_templates/create"})
end

def update
  #Parameters: {"query_image"=>"a", "query_caption"=>"aakjkj", "modify_id"=>"952"}

  the_id = params.fetch("modify_id")

  matching_photos = Photo.where ({ :id => the_id })

  the_photo = matching_photos.at(0)

  input_image = params.fetch("query_image")
  input_caption = params.fetch("query_caption")

  the_photo.image = input_image
  the_photo.caption = input_caption

  the_photo.save

  #render({ :template => "photo_templates/update"})

  next_url = "/photos/" + the_photo.id.to_s

  redirect_to(next_url)
end

def comment
  input_photo_id = params.fetch("input_photo_id")
  input_author_id = params.fetch("input_author_id")
  input_body = params.fetch("input_body")

  new_comment = Comment.new
  new_comment.photo_id = input_photo_id
  new_comment.author_id = input_author_id
  new_comment.body = input_body
  new_comment.save

  matching_photos = Photo.where(id: input_photo_id)
  the_photo = matching_photos.first

  next_url = "/photos/" + the_photo.id.to_s
  redirect_to(next_url)
end

end
 