namespace :dev do

  DEFAULT_PASSWORD = 123123
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropando bases!") {%x(rails db:drop )}
      show_spinner("Criando bases!") {%x(rails db:create )}
      show_spinner("Fazendo migrações")  {%x(rails db:migrate)}
       #do -end podem ser trocados por {} somente se há linha única
      show_spinner("Criando o Administrador padrão...") { %x(rails dev:add_default_admin) } 
      show_spinner("Criando Administradores extras...") { %x(rails dev:add_extra_admins) } 
      show_spinner("Criando o Usuário padrão...") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando assuntos padrões...") { %x(rails dev:add_subjects) }
      show_spinner("Cadastrando perguntas e respostas padrões...") { %x(rails dev:add_answers_and_questions) }
    else
      puts ("Você não está em ambiente de desenvolvimento!")  
    end  
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
    email: 'admin@admin.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administradores extras"
    9.times do |i|
      task add_extra_admins: :environment do
        Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
        )
      end
    end  

  desc "Adiciona o User padrão"
  task add_default_user: :environment do
    User.create!(
    email: 'user@user.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona assuntos padrões"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas padrões"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject| 
      rand(5..10).times do |i|
        params = { question: {
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}", 
          subject: subject,
          answers_attributes:[]
        }}

        rand(2..5).times do |j|
            params[:question][:answers_attributes].push(
              { description: Faker::Lorem.sentence, correct: false}
            )
        end 

        index = rand(params[:question][:answers_attributes].size)
        params[:question][:answers_attributes][index] = { description: Faker::Lorem.sentence, correct: true}

        Question.create!(params[:question])
      end  
    end  
  end

  private
  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :dots_10)
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end

