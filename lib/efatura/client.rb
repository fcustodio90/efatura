module Efatura
  class Client
    attr_accessor :from_date, :to_date
    attr_accessor :cookies

    LOGIN_URL = 'https://www.acesso.gov.pt/jsp/loginRedirectForm.jsp?path=painelAdquirente.action&partID=EFPF'
    CONSUMIDOR_URL = 'https://faturas.portaldasfinancas.gov.pt/painelAdquirente.action'
    FATURAS_URL = 'https://faturas.portaldasfinancas.gov.pt/json/obterDocumentosAdquirente.action'

    def initialize(from_date, to_date)
      @from_date = from_date
      @to_date = to_date
    end

    def invoices
      login
      response = RestClient::Request.execute(
        method: :get,
        url: FATURAS_URL,
        cookies: cookies,
        headers: {
          params: {
            'dataInicioFilter' => from_date,
            'dataFimFilter' => to_date,
            'ambitoAquisicaoFilter' => 'TODOS'
          }
        }
      )
      JSON.parse(response)
    end

    def date_valid?(from_date, to_date)
      # FOR A DATE TO BE VALID IT NEEDS TO PASS THE THREE CONDITIONS
      date_format_valid?(from_date) && date_format_valid?(to_date) && date_same_year?(from_date, to_date)
    end

    def date_format_valid?(date)
      # RECEIVE A DATE INSTANCE VARIABLE AND VERIFIES THE CORRECT FORMAT
      format = '%Y-%m-%d'
      DateTime.strptime(date, format)
      true
    rescue ArgumentError
      false
    end

    def date_same_year?(from_date, to_date)
      Date.parse(from_date).year == Date.parse(to_date).year
    end

    private

    def login
      # SET AN EMPTY HASH TO FEED LATER WITH AGENT COOKIE JAR
      @cookies = {}
      # INITIATE A NEW MECHANIZE INSTANCE
      agent = Mechanize.new
      # FETCH THE LOGIN URL AND ITERATES THRO LOGIN_PAGE IN ORDER TO TARGET HTML COMPONENTS
      agent.get(LOGIN_URL) do |login_page|
        # FETCHES THE LOGIN FORM FROM THE LOGIN PAGE
        login_form = login_page.form_with(name: 'loginForm')
        # SETS THE LOGIN USERNAME AKA NIF / NUMERO CONTRIBUINTE
        login_form.username = Efatura.configuration.nif
        # SETS THE LOGIN PASSWORD
        login_form.password = Efatura.configuration.password
        # SUBMITS THE FORM / LOGIN
        agent.submit(login_form)
        # AFTER A SUCCESSFUL LOGIN FETCH THE CONSUMIDOR PAGE IN ORDER TO RETRIEVE COOKIES
        consumidor_page = agent.get(CONSUMIDOR_URL)
        # ASSIGN THE CONSUMIDOR FORM TO A VARIABLE
        consumidor_form = consumidor_page.form_with(name: 'form')
        # SUBMIT THE FORM
        agent.submit(consumidor_form)
        # MAPS THE COOKIE_JAR FROM AGENT OBJECT AND FEEDS IT TO THE COOKIES HASH
        # THAT WAS INITIALIZED WITH AN EMPTY HASH
        @cookies = Hash[agent.cookie_jar.store.map { |i| i.cookie_value.split('=') }]
      end
    end
  end
end
