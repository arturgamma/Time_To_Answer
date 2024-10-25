module AdminsBackofficeHelper
  def translate_attribute(object = nil, method = nil)
    if object && method
      object.model.human_attribute_name(method)     
    else
      "Impossível encontrar os atributos necessários, favor informar os parâmetros corretamente!"
    end   
  end  
end
