require_relative 'webhook_registration'
require_relative 'orcid_api'
require_relative 'file_util'

# Get file handler
file_util = FileUtil.new()
orcidsProcessed = file_util.readToArray('successful_orcids.txt')
orcidsProcessed += file_util.readToArray('failed_orcids.txt')

orcid_api = OrcidApi.new()
access_token = orcid_api.getAccessToken
puts access_token

webhook = WebhookRegistration.new()
orcids = webhook.listAllHookedOrcids

orcids.each do |orcid|
  if !orcidsProcessed.include? orcid
    ret = orcid_api.unregister(orcid, access_token)
    if (ret == 204)
      # puts "Successful"
      file_util.appendToFile(orcid, "successful_orcids.txt")
    else
      # puts "Failed"
      file_util.appendToFile(orcid, "failed_orcids.txt")
    end
  end
end
