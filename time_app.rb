require 'rack'

class TimeApp
  FORMATS = %w[year month day hour minute second].freeze

  def call(env)
    req = Rack::Request.new(env)

    if req.path == '/time'
      formats = req.params['format']&.split(',')
      unknown_formats = formats.reject { |f| FORMATS.include?(f) }

      if unknown_formats.any?
        return [
          400,
          { 'content-type' => 'text/plain' },
          ["unknown time format [#{unknown_formats.join(', ')}]"]
        ]
      end

      time = Time.now
      response_time = formats.map do |format|
        case format
        when 'year'
          time.strftime('%Y')
        when 'month'
          time.strftime('%m')
        when 'day'
          time.strftime('%d')
        when 'hour'
          time.strftime('%H')
        when 'minute'
          time.strftime('%M')
        when 'second'
          time.strftime('%S')
        end
      end.join('-')

      return [
        200,
        { 'content-type' => 'text/plain' },
        [response_time]
      ]
    end

    [404, { 'content-Type' => 'text/plain' }, ['not found']]
  end
end
