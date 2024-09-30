module FormatHelper

  def format_date(date, format: :day_month_year_full)
    return date if date.nil?

    case format
    when :day_month_year_full
      format_str = '%d, %B %Y'
    else
      format_str = ''
    end

    date.strftime(format_str)
  end

  def format_date_range(from_date, to_date, format: :day_month_year_full)
    [format_date(from_date, format:), format_date(to_date, format:)].compact.join(' - ')
  end

  def format_price(price, currency: :php)
    return if price.nil? || price.zero?

    case currency
    when :php
      currency_sign = '₱'
    else
      currency_sign = ''
    end

    "#{currency_sign} #{number_with_delimiter(price)}"
  end

end
