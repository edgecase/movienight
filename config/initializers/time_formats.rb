formats = {
  :date => "%B %d",
  :time => "%I:%M%p"
}

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(formats)
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(formats)

