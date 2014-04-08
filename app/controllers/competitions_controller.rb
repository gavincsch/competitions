class CompetitionsController < ApplicationController
  before_filter :confirm_logged_in, :except => [:show , :create_entry, :thankyou]
  #before_filter :checkIfValidCompetition , :only => [:show]
  def index
    @campaigns = Competition.all
  end

  def show
    @campaign = Competition.find_by_campaign(params[:id])
    @entry = Entry.new

  end

  def edit
    @campaign = Competition.find_by_campaign(params[:id])
    @images = Image.all
  end

  def new
    @campaign = Competition.new
    @images = Image.all
  end

  def create
    @campaign = Competition.new(campaign_params)

      respond_to do |format|
        if @campaign.save
          format.html { redirect_to competition_path(@campaign.campaign_url), :notice => 'Competition was successfully created.' }
        else
          format.html {redirect_to new_competition_path, :notice => 'error.'}
          format.json { render json: @campaign.errors, status: :unprocessable_entity }
        end
      end
  end

  def thankyou
    @campaign = Competition.find_by_campaign(params[:id])
  end

  def update
    @campaign = Competition.find(params[:id])

    respond_to do |format|
      if @campaign.update_attributes(campaign_params)
        format.html { redirect_to competition_path(@campaign.campaign_url), :notice => 'Competition was successfully updated.' }
      else
        format.html {redirect_to edit_competition_path(@campaign.campaign_url), :notice => 'error.'}
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @campaign = Competition.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to competitions_path , notice: 'User was successfully destroyed'}
    end
  end

  def campaign_params
    params.require(:competition).permit(:campaign,
                                        :campaign_url,
                                        :date_from,
                                        :date_to,
                                        :enter_image,
                                        :thankyou_image,
                                        :birthday,
                                        :likes_sports,
                                        :has_kids,
                                        :active
    )
  end

  def entries
    @campaign =  Competition.find_by_campaign(params[:campaign])
    @entries = Entry.find_all_by_fk_competition_id(@campaign.id)
  end

  def create_entry
    @entry = Entry.new(entry_params)
    @campaign = Competition.find_by_campaign(params[:campaign])

    respond_to do |format|
      if @entry.save
        format.html { redirect_to :action => 'thankyou', :notice => 'You Have successfully entered.' }
      else
        format.html {redirect_to new_competition_path, :notice => 'error.'}
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def entry_params
    params.require(:entry).permit(:firstname,
                                        :surname,
                                        :email,
                                        :mobile,
                                        :region,
                                        :dob,
                                        :gender,
                                        :newsletter,
                                        :source,
                                        :q1,
                                        :q2,
                                        :competition_id
    )
  end

  def checkIfValidCompetition
    @campaign =  Competition.find_by_campaign(params[:id])
    current_user

      unless Date.today.between?(@campaign.date_from.to_date, @campaign.date_to.to_date)
        unless session[:user_id]
          redirect_to :root
        end
     end

    if @campaign.active === false
      confirm_logged_in
    end

  end



end
