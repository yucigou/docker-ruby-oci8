require_relative 'webhook_registration'
require_relative 'orcid_api'
require_relative 'file_util'

# Get file handler
file_util = FileUtil.new()

orcid_api = OrcidApi.new()
access_token = orcid_api.getAccessToken
puts access_token

webhook = WebhookRegistration.new()
orcids = webhook.listAllHookedOrcids

orcids.each do |orcid|
  ret = orcid_api.register(orcid, access_token)
  if (ret == 201 || ret == 204)
    # puts "Successful"
    file_util.appendToFile(orcid, "successful_orcids.txt")
  else
    # puts "Failed"
    file_util.appendToFile(orcid, "failed_orcids.txt")
  end
end
