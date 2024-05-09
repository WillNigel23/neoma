class NeomaMailersController < ApplicationController

  def inquire
    @inquiry = Spina::Mail.new(inquiry_params)
    @mailinglist = Spina::Mailinglist.new(email: @inquiry.email)

    @mailinglist.save
    respond_to do |format|
      if @inquiry.save
        @flash = [[:success, t('flash.inquiry.success')]]
      else
        @flash = [[:error, @inquiry.errors.full_messages.join(', ')]]
      end
      format.turbo_stream
    end
  end

  def add_to_mailinglist
    @mailinglist = Spina::Mailinglist.new(mailinglist_params)

    respond_to do |format|
      if @mailinglist.save
        @flash = [[:success, t('flash.mailinglist.success')]]
      else
        @flash = [[:error, @mailinglist.errors.full_messages.join(', ')]]
      end
      format.turbo_stream
    end
  end

  private

  def mailinglist_params
    params.require(:mailinglist).permit(:email)
  end

  def inquiry_params
    params.require(:mail).permit(:first_name, :last_name, :email, :phone_number, :message, :artwork_id)
  end

end
