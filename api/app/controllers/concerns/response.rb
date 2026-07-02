module Response
  def json_response(object, status: :ok, includes: [])
    render json: object.as_json(except: ["password_digest"], include: includes), status: status
  end

  def html_response(object, status: :ok)
    render html: object, status: status
  end
end

