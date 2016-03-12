FitnessTimeApi::App.controllers :rutinaService do
  
  get :registrar, :map => '/crear' do
    
    securityToken = SecurityToken.find_by_authToken(:authToken => params[:authToken])
    if securityToken == nil
      get_error_response(413,'Usuario no autorizado.')
    else
            
    end
  end
end