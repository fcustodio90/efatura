EfaturaScraper.configure do |config|
  config.nif = nil
  config.password = nil
  config.login_url = 'https://www.acesso.gov.pt/jsp/loginRedirectForm.jsp?path=painelAdquirente.action&partID=EFPF'
  config.consumidor_url = 'https://faturas.portaldasfinancas.gov.pt/painelAdquirente.action'
  config.faturas_url = 'https://faturas.portaldasfinancas.gov.pt/json/obterDocumentosAdquirente.action'
end
