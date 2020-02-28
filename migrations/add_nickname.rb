require 'yaml'

Dir['cves/*.yml'].each do |yml_file|

    h = YAML.load(File.open(yml_file, 'r').read)
    h['nickname'] = ''
    h['nickname_instructions'] = <<~EOS
      A catchy name for this vulnerability that would draw attention it. If the
      report mentions a nickname, use that. Must be under 30 characters.
      Optional.
    EOS
    File.open(yml_file, "w+") do |file|
      yml_txt = h.to_yaml[4..-1] # strip off ---\n
      file.write(yml_txt)
    end
end
