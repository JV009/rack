class TimeFormatter
  FORMATS = %w[year month day hour minute second].freeze

  FORMAT_MAP = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(formats)
    @formats = formats
  end

  def format_time
    time = Time.now
    formatted_time = []
    unknown_formats = []

    @formats.each do |format|
      if FORMATS.include?(format)
        formatted_time << time.strftime(FORMAT_MAP[format])
      else
        unknown_formats << format
      end
    end

    formatted_time_string = formatted_time.join('-')
    [formatted_time_string, unknown_formats]
  end
end
