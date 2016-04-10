module CustomSpecsHelpers
  def t(string, options={})
    I18n.t(string, options)
  end

  def factory_file(file_name)
    file_name ||= 'rails.jpg'
    Rails.root.join("spec/factories/#{file_name}")
  end
end
