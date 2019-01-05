require 'efatura/version'
require 'efatura/configuration'

module Efatura
  require 'mechanize'
  require 'rest-client'
  require 'date'
  require 'json'
  # EFATURA SCRAPER GEM. IT USES MECHANIZE TO SIMULATE A LOGIN TO EFATURA WEBSITE
  # IT THEN REDIRECTS TO CONSUMIDOR PAGE IN ORDER TO FETCH THE NECESSARY COOKIES
  # TO BUILD A REST-CLIENT REQUEST WITH COOKIES AS HEADERS
  # EFATURA WEBSITE IS POPULATED WITH AJAX REQUESTS
  # SO THE GOAL IS FETCH THE SAME JSONS THEY USE TO FEED DATA TO THE WEBSITE
  class Efatura

    LOGIN_URL = 'https://www.acesso.gov.pt/jsp/loginRedirectForm.jsp?path=painelAdquirente.action&partID=EFPF'
    CONSUMIDOR_URL = 'https://faturas.portaldasfinancas.gov.pt/painelAdquirente.action'
    FATURAS_URL = 'https://faturas.portaldasfinancas.gov.pt/json/obterDocumentosAdquirente.action'

    def invoices
      # CALL THE SUCCESSFUL LOGIN
      login
      # SET THE RESPONSE REQUEST BY GIVING THE AJAX / JSON URL USED BY EFATURA
      # AND ASSIGNING THE COOKIE HEADERS
      response = RestClient::Request.execute(
        method: :get,
        url: faturas_url,
        cookies: cookies,
        headers: {
          params: {
            'dataInicioFilter' => s_date,
            'dataFimFilter' => e_date,
            'ambitoAquisicaoFilter' => 'TODOS'
          }
        }
      )
      # RETURNS ALL THE INVOICES REGISTED IN EFATURA AT THE GIVEN TIMEFRAME
      JSON.parse(response)
    end

    private

    def date_valid?
      # FOR A DATE TO BE VALID IT NEEDS TO PASS THE THREE CONDITIONS
      date_format_valid?(s_date) && date_format_valid?(e_date) && date_same_year?
    end

    def date_format_valid?(date)
      # RECEIVE A DATE INSTANCE VARIABLE AND VERIFIES THE CORRECT FORMAT
      format = '%Y-%m-%d'
      DateTime.strptime(date, format)
      true
    rescue ArgumentError
      false
    end

    def date_same_year?
      # ANALYZES IF BOTH DATES ARE FROM THE SAME YEAR
      s_date[0..3] == e_date[0..3]
    end

    def login
      # IF DATE IS VALID EXECUTES THE LOGIN METHOD
      if date_valid?
        # INITIATE A NEW MECHANIZE INSTANCE
        agent = Mechanize.new
        # FETCH THE LOGIN URL AND ITERATES THRO LOGIN_PAGE IN ORDER TO TARGET HTML COMPONENTS
        agent.get(login_url) do |login_page|
          # FETCHES THE LOGIN FORM FROM THE LOGIN PAGE
          login_form = login_page.form_with(name: 'loginForm')
          # SETS THE LOGIN USERNAME AKA NIF / NUMERO CONTRIBUINTE
          login_form.username = nif
          # SETS THE LOGIN PASSWORD
          login_form.password = password
          # SUBMITS THE FORM / LOGIN
          agent.submit(login_form)
          # AFTER A SUCCESSFUL LOGIN FETCH THE CONSUMIDOR PAGE IN ORDER TO RETRIEVE COOKIES
          consumidor_page = agent.get(consumidor_url)
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
end
