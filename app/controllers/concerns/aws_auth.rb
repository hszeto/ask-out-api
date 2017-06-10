module AwsAuth
  extend ActiveSupport::Concern

  require 'aws-sdk'

  def get_cognito_user(token)
    cognitoidentityprovider = Aws::CognitoIdentityProvider::Client.new(region: ENV['AWS_REGION'])

    begin
      cognito_user = cognitoidentityprovider.get_user({
        # access_token: "eyJraWQiOiJzaGZ1cVJLdmJLTElNVWpqRjJQTDMzWlVZaFNpNmhuTUlZb0FibkZPREVrPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJmMDA0YzdlNi0wYWRmLTRiNWUtOWI0My05N2FjZDhlMzI5MjEiLCJkZXZpY2Vfa2V5IjoidXMtd2VzdC0yXzg2NDFmMWFkLWEyMjctNGExZi04NWIxLTcxZGMxYjQxMjIxOCIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtd2VzdC0yLmFtYXpvbmF3cy5jb21cL3VzLXdlc3QtMl9kQkw5TFM0UW4iLCJleHAiOjE0OTY2NDc1ODksImlhdCI6MTQ5NjY0Mzk4OSwianRpIjoiZGI4YmM2MWEtNWE2MC00Y2IzLWEzMWUtNjU3MGFiMjY5ZjRiIiwiY2xpZW50X2lkIjoiNXFqbHN1dXZ1cWU3M2NnbmthOTJudThyZDAiLCJ1c2VybmFtZSI6InVjbGFAaG90bWFpbC5jb20ifQ.HcBVwxE-BOc8RwrgU20SfP1xpkEfzcGYWySCgfi8gwXUIixipVlSUbcrIQpB_GhC4Rs0DYRBBwiIdCJh28FkJ9NbSwMGNFZlNzE4cnBcLCjxHnZ0B0jWAKKQ3F1cpZW5lsRjYR7A5KnWl1tTzUqRQHOb_pAETovm6IR4eYVeJg0427YOf9-194ldxDkBAgv1osKRoWlK1NSwQQANTcWYEwr02EKy2tp0lNmHsWB6ed7OzcyL4xFZBHfRrb8tgj8ZEt27NgLaPeQLkwP0P8PaRkgL2z7VjWnepQiikjf_xCRXJHYG5WSwiqoELjb1nQk1JpY_hN2oFS2O-GVwOJ74rw"
        access_token: token
      })

      email_verified = cognito_user.user_attributes
                                   .detect{ |attribute_type| attribute_type["name"] === "email_verified" && attribute_type["value"] === "true" }

      if email_verified.nil?
        raise "Email is not verified"
      else
        puts "Token is good. Email returned."
        return {"email" => cognito_user.username}
      end

    rescue StandardError => msg
      puts "ERROR: #{msg}"
      return {"error" => msg}
    end
  end
end
