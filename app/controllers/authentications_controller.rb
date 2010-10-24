class AuthenticationsController < ActionController::Base

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["rack.auth"]
    Resque.enqueue_at(1.minute.from_now, SendTweet, auth['credentials']['token'], auth['credentials']['secret'], "in da house forca!")
    render :text => auth.to_yaml
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
