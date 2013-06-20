class Admin::SoldiersController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, User::ROLES[:user])
  end

  # GET /soldiers
  # GET /soldiers.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: SoldiersDatatable.new(view_context) }
    end
  end

  # GET /soldiers/1
  # GET /soldiers/1.json
  def show
    @soldier = Soldier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @soldier }
    end
  end

  # GET /soldiers/new
  # GET /soldiers/new.json
  def new
    @soldier = Soldier.new

    # create the translation object for the locales that were selected
	  # so the form will properly create all of the nested form fields
		I18n.available_locales.each do |locale|
			@soldier.soldier_translations.build(:locale => locale.to_s)
		end

    gon.edit_soldier = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @soldier }
    end
  end

  # GET /soldiers/1/edit
  def edit
    @soldier = Soldier.find(params[:id])
    gon.edit_soldier = true
		gon.born_at = @soldier.born_at.strftime('%m/%d/%Y') if @soldier.born_at.present?
		gon.died_at = @soldier.died_at.strftime('%m/%d/%Y') if @soldier.died_at.present?
  end

  # POST /soldiers
  # POST /soldiers.json
  def create
    @soldier = Soldier.new(params[:soldier])

    respond_to do |format|
      if @soldier.save
        format.html { redirect_to admin_soldier_path(@soldier), notice: t('app.msgs.success_created', :obj => t('activerecord.models.soldier')) }
        format.json { render json: @soldier, status: :created, location: @soldier }
      else
        gon.edit_soldier = true
		    gon.born_at = @soldier.born_at.strftime('%m/%d/%Y') if @soldier.born_at.present?
		    gon.died_at = @soldier.died_at.strftime('%m/%d/%Y') if @soldier.died_at.present?
        format.html { render action: "new" }
        format.json { render json: @soldier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /soldiers/1
  # PUT /soldiers/1.json
  def update
    @soldier = Soldier.find(params[:id])

    respond_to do |format|
      if @soldier.update_attributes(params[:soldier])
        format.html { redirect_to admin_soldier_path(@soldier), notice: t('app.msgs.success_created', :obj => t('activerecord.models.soldier')) }
        format.json { head :ok }
      else
        gon.edit_soldier = true
		    gon.born_at = @soldier.born_at.strftime('%m/%d/%Y') if @soldier.born_at.present?
		    gon.died_at = @soldier.died_at.strftime('%m/%d/%Y') if @soldier.died_at.present?
        format.html { render action: "edit" }
        format.json { render json: @soldier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /soldiers/1
  # DELETE /soldiers/1.json
  def destroy
    @soldier = Soldier.find(params[:id])
    @soldier.destroy

    respond_to do |format|
      format.html { redirect_to adminsoldiers_url }
      format.json { head :ok }
    end
  end
end
