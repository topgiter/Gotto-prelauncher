class UsersController < ApplicationController
   # before_filter :authenticate_user!, only: [:new]

  def new
    @bodyId = 'home'
    @is_mobile = mobile_device?    

    @user = User.new
  end

  def create
    # Get user to see if they have already signed up
    @user = User.find_by_email(params[:user][:email]);
    # If user doesnt exist, make them, and attach referrer
    if @user.nil?
      cur_ip = IpAddress.find_by_address(request.env['HTTP_X_FORWARDED_FOR'])

      if !cur_ip
        cur_ip = IpAddress.create(
          :address => request.env['HTTP_X_FORWARDED_FOR'],
          :count => 0
        )
      end
      
      if cur_ip.count > 1
        return redirect_to root_path, :alert => "You tried to sign up twice with same ip address."
      else
        cur_ip.count = cur_ip.count + 1
        cur_ip.save
      end

      referred_by = User.find_by_referral_code(params[:ref])
      
      if referred_by
        referred_by.referral_registered_number += 1
        referred_by.save
      end

      @user = User.new(:email => params[:user][:email])

      if referred_by.present?
        @user.referrer = referred_by
      end

      @user.save

    end

    session[:user_id] = @user.id

    # Send them over refer action
    if @user
      redirect_to '/refer-a-friend'
    else
      redirect_to root_path, :alert => "Something went wrong!"
    end
  end

  def refer
    @bodyId = 'refer'
    @is_mobile = mobile_device?

    if current_user.nil?
      format.html { redirect_to root_path, :alert => "Something went wrong!" }
    end
  end
end
