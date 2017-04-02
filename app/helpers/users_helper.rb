module UsersHelper
  def capitalize_name(name)
    names = name.split(' ')
    names.each {|n| n[0] = n[0].upcase}
    names.join(' ')
  end
end
