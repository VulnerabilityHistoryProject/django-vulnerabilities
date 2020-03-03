require 'yaml'

# MIGRATION STATUS: Not done.
# raise 'Migration already performed.' # Don't run this. Kept for posterity

def order_of_keys
  %w(
    CVE
    yaml_instructions
    curated_instructions
    curated
    reported_instructions
    reported_date
    announced_instructions
    announced_date
    published_instructions
    published_date
    description_instructions
    description
    bounty_instructions
    bounty
    reviews
    bugs
    repo
    fixes_vcc_instructions
    fixes
    vccs
    upvotes_instructions
    upvotes
    unit_tested
    discovered
    discoverable
    specification
    subsystem
    interesting_commits
    i18n
    sandbox
    ipc
    lessons
    mistakes
    CWE_instructions
    CWE
    CWE_note
    nickname
    nickname_instructions
  )
end

def updated_yaml_instructions
  <<~EOS
===YAML Primer===
This is a dictionary data structure, akin to JSON.
Everything before a colon is a key, and the values here are usually strings
For one-line strings, you can just use quotes after the colon
For multi-line strings, as we do for our instructions, you put a | and then
indent by two spaces

For readability, we hard-wrap multi-line strings at 80 characters. This is not absolutely required, but appreciated.
  EOS
end

def discoverable_question
  instructions = <<~EOS
Is it plausible that a fully automated tool could have discovered this? These
are tools that require little knowledge of the domain, e.g. automatic static
analysis, compiler warnings, fuzzers.

Examples for true answers: SQL injection, XSS, buffer overflow

Examples for false: RFC violations, permissions issues, anything that
    requires the tool to be "aware" of the project's domain-specific
    requirements.

The answer field should be boolean. In answer_note, please explain why you come to that conclusion.
  EOS
  return {
    'instructions' => instructions,
    'answer_note' => nil,
    'answer' => nil
  }
end

def spec_question
  specification_instructions = <<~EOS
Is there mention of a violation of a specification? For example,
an RFC specification, a protocol specification, or a requirements
specification.

Be sure to check all artifacts for this: bug report, security advisory, commit message, etc.

The answer field should be boolean. In answer_note, please explain why you come to that conclusion.
  EOS
  return {
    'instructions' => specification_instructions,
    'answer_note' => nil,
    'answer' => nil
  }
end


Dir['cves/*.yml'].each do |yml_file|
    h = YAML.load(File.open(yml_file, 'r').read)
    h['yaml_instructions'] = updated_yaml_instructions
    h['discoverable'] = discoverable_question
    h['specification'] = spec_question
    # Reconstruct the hash in the order we specify
    out_h = {}
    order_of_keys.each do |key|
      out_h = h[key]
    end

    # Generate the new YML, clean it up, write it out.
    File.open(yml_file, "w+") do |file|
      yml_txt = h.to_yaml[4..-1] # strip off ---\n
      stripped_yml = ""
      yml_txt.each_line do |line|
        stripped_yml += "#{line.rstrip}\n" # strip trailing whitespace
      end
      file.write(stripped_yml)
      print '.'
    end
end
puts 'Done!'
