class User::HomesController < ApplicationController
    def top
    end
    def about
    end
    def index
        @illustrations = Illustration.all
    end
end
