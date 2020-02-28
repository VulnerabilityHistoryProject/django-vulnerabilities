class NewDjangoCVEs

  def initialize(security_txt)
    @security_txt = security_txt
  end

  def run
    File.open(@security_txt) do |f| # rst_cve means "reStructured Text"
      cves = f.read.scan(/:cve:`[\d\-]*`/).each do |rst_cve|
        cve = cve_from_rst(rst_cve)
        puts "#{cve} ..... #{yml_exists?(cve)}"
        unless yml_exists?(cve)
        end
      end
    end
  end

  def new_cve(cve_yml)

  end

  def yml_exists?(cve)
    File.exist? "cves/#{cve}.yml"
  end

  def cve_from_rst(rst_cve)
    cve = rst_cve.match(/:cve:`([\d\-]*)`/).captures[0]
    return "CVE-#{cve}"
  end

end
