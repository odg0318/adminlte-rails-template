class CreateAdminService
  def create_roles
    Role.create(role_type: 'admin', name: '관리자')
    Role.create(role_type: 'board', name: '경영진')
    Role.create(role_type: 'guest', name: '일반사용자')
  end

  def create_admin 
    admin_role = Role.find_by(role_type: 'admin')

    user = User.new
    user.email = Rails.application.secrets.admin_email
    user.name = Rails.application.secrets.admin_name
    user.password = Rails.application.secrets.admin_password
    user.password_confirmation = Rails.application.secrets.admin_password
    user.role = admin_role
    User.find_or_create_by!(email: Rails.application.secrets.admin_email,
                            name: Rails.application.secrets.admin_name) do |user|
      user.password = Rails.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admin_password
      user.role = admin_role
    end
  end
end
