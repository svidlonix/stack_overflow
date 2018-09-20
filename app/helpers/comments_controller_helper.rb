module CommentsControllerHelper
  def object_comment_class(object)
    if object.instance_of? Answer
      ".answer-comments-#{object.id}"
    else
      '.question-comments'
    end
  end
end
