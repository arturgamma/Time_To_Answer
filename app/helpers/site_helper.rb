module SiteHelper
    def msg_jumbotrom
        case params[:action]
        when 'index'
            "Últimas perguntas cadastradas"
        when 'questions'
            "Resultados para \"#{params[:term]}\""
        when 'subject'
            "Mostrando questôes do assunto \"#{params[:subject]}\""
        end    
    end
end
