class CommentDecorator < Draper::Decorator
  delegate_all
  include Postable
end
