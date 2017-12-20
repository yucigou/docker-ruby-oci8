require 'oci8'

class WebhookRegistration
  def initialize()
    @oci = OCI8.new('username','password','host:port/database')
  end

  def register
    @oci.exec('select ORCID from ORCID_PERSONAL_DETAILS WHERE HOOKED = 1 AND rownum <= 10') do |record|
      puts record
    end
  end

  def listAllHookedOrcids
    hookedOrcids = []
    @oci.exec('select ORCID from ORCID_PERSONAL_DETAILS WHERE HOOKED = 1') do |record|
      hookedOrcids << record[0]
    end
    return hookedOrcids
  end

  def listYuciHookedOrcid
    hookedOrcids = []
    @oci.exec("select ORCID from ORCID_PERSONAL_DETAILS WHERE HOOKED = 1 AND ORCID = '0000-0001-7155-7939'") do |record|
      hookedOrcids << record[0]
    end
    return hookedOrcids
  end

  def showTables
    @oci.exec('select table_name from user_tables') do |record|
      puts record
    end
  end

  def showAccessToken
    @oci.exec('select * from ORCID_ACCESS_TOKENS where rownum <= 10') do |record|
      puts record
    end
  end

  def describeTable
    @oci.exec("select column_name from user_tab_cols where table_name = 'ORCID_ACCESS_TOKENS'") do |record|
      puts record
    end
  end

  def listAccessTokens
    @oci.exec('select p.ORCID, a.ACCESS_TOKEN from ORCID_PERSONAL_DETAILS p inner join ORCID_ACCESS_TOKENS a on p.ORCID = a.ORCID WHERE p.HOOKED = 1 AND rownum <= 10') do |record|
      puts record
    end
  end

end


