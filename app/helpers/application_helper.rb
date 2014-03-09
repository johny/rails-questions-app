module ApplicationHelper

  def letter(i)
    case i
    when 0
      'A'
    when 1
      'B'
    when 2
      'C'
    when 3
      'D'
    end
  end


  def answer_class(answer, user_reply)
    html_class = "list-group-item"

    if answer.is_correct?
        html_class += " list-group-item-success"
    else
      if user_reply != nil && (answer.id == user_reply.answer_id)
        html_class += " list-group-item-danger"
      end
    end



    return html_class

  end

end
