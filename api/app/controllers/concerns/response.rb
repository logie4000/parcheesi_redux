module Response
  def json_response(object, status = :ok)
    render json: object.as_json(except: ["password_digest"]), status: status
  end

  def html_response(object, status = :ok)
    render html: object, status: status
  end
end

