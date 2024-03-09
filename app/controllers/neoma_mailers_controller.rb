# frozen_string_literal: true

class NeomaMailersController < ApplicationController
  def add_to_mailinglist
    @mailinglist = Spina::Mailinglist.new(mailinglist_params)

    respond_to do |format|
      @flash = if @mailinglist.save
                 [[:success, t('flash.mailinglist.success')]]
               else
                 [[:error, @mailinglist.errors.full_messages.join(', ')]]
               end
      format.turbo_stream
    end
  end

  private

  def mailinglist_params
    params.require(:mailinglist).permit(:email)
  end
end
