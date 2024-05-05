# frozen_string_literal: true

module FormatHelper
  def format_date(date, format: :day_month_year_full)
    return date if date.nil?

    format_str = case format
                 when :day_month_year_full
                   '%d, %B %Y'
                 else
                   ''
                 end

    date.strftime(format_str)
  end

  def format_date_range(from_date, to_date, format: :day_month_year_full)
    [format_date(from_date, format:), format_date(to_date, format:)].compact.join(' - ')
  end

  def format_price(price, currency: :php)
    return price if price.nil?

    currency_sign = case currency
                    when :php
                      '₱'
                    else
                      ''
                    end

    "#{currency_sign} #{number_with_delimiter(price)}"
  end
end
