class Admin::DashboardController < AdminController
before_filter :authenticate_admin!
def index
# find me in dashboard/index
@users = Account.count
@active_users = Account.where(:status => '1').count
end
end
