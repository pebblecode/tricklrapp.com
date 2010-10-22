class AuthenticationsController < ActionController::Base

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["rack.auth"]
    oauth = Twitter::OAuth.new("jTogT14Qg3JVoSUTY8aMg", "8iIUvM66i3PGrzxl0cGXGTqSmXkHp1Y1mDtf6PyaRE")
    oauth.authorize_from_access(auth['credentials']['token'], auth['credentials']['secret'])
    client = Twitter::Base.new(oauth)
    client.update('We made it!')
    render :text => auth.to_yaml
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
