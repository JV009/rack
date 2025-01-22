class TimeApp
  def call(env)
    req = Rack::Request.new(env)

    if req.path == '/time'
      handle_time_request(req)
    else
      not_found_response
    end
  end

  def handle_time_request(req)
    formats = req.params['format']&.split(',')
    formatter = TimeFormatter.new(formats)

    if invalid_formats?(formatter)
      return unknown_format_response(formatter.unknown_formats)
    end

    response_time = formatter.format_time
    success_response(response_time)
  end

  def invalid_formats?(formatter)
    formatter.unknown_formats.any?
  end

  def unknown_format_response(unknown_formats)
    response(400, ["unknown time format [#{unknown_formats.join(', ')}]"])
  end

  def success_response(response_time)
    response(200, [response_time])
  end

  def not_found_response
    response(404, ['not found'])
  end

  private

  def response(status, body)
    headers = { 'content-type' => 'text/plain' }
    [status, headers, body]
  end
end
