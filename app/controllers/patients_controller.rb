class PatientsController < ApplicationController
  def person_params
    params.require(:patient).permit(:email, :phone_number,
                                    :first_name, :last_name, :patronymic)
  end
end
