require 'csv'

class CsvController < ApplicationController
    def export
        @csv = Csv.where(organization_id: current_user.organization_id)

        respond_to do |format|
            format.csv do
                response.headers['Content-Type'] = 'text/csv'
                response.headers['Content-Disposition'] = "attachment; filename=leads.csv"
            end
        end
    end
end