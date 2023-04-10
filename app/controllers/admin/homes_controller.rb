class Admin::HomesController < ApplicationController
    def top
        @illustrations_favorite = Illustration.where(is_draft: false).search(params[:search]).includes(:favorited_accounts).sort {|a,b| b.favorited_accounts.size <=> a.favorited_accounts.size}
    end
end
