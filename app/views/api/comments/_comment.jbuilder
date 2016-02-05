json.extract! comment, :id, :message, :created_at
json.time_ago "#{time_ago_in_words(comment.created_at)} ago"
json.user do
  json.partial! "users/user", locals: { user: comment.user }
end