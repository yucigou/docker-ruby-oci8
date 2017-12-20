class FileUtil
  def appendToFile(orcid, file_name)
    open(file_name, 'a') { |f|
      f.puts orcid
    }
  end

  def readToArray(file_name)
    orcidList = []
    File.readlines(file_name).each do |line|
      line.gsub!(/\r?\n?/, '')
      orcidList << line
    end
    return orcidList
  end
end
