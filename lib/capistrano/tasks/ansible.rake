require "English"

# This method creates roles from an Ansible inventory

def ansible_roles(file = nil)
  file ||= "config/ansible/#{fetch(:stage)}"

  contents = IO.read(file)

  header = '=' * 30 + " Reading roles from Ansible inventory " + '=' * 30
  puts header

  current_role = nil
  contents.split("\n").each do |line|
    next if line.strip.start_with? '#'

    if line =~ /^\[(\w+)\]/
      current_role = $1
    elsif line =~ /^(?<hostname>[\.\w]+).+ (ansible_ssh_host=(?<ssh_ip>[\.\w]+))?/
      if current_role.nil?
        puts "[INFO] Host without role found. Skipping: #{line}"
        next
      end

      hostname = $LAST_MATCH_INFO[:hostname]
      ssh_ip = $LAST_MATCH_INFO[:ssh_ip]

      fail "SSH IP is nil for #{hostname}" if ssh_ip.nil?

      no_release = !(line =~ /no_release=true/).nil?

      host_string = format('%-20s', ssh_ip || hostname)
      puts "Creating role: #{format('%-10s', current_role)} host: #{host_string} no_release: #{no_release}"

      role current_role, ssh_ip || hostname, no_release: no_release
    elsif !line.strip.empty?
      fail "[ERROR] found unparsable line: #{line}"
    end
  end
  puts '=' * header.length
end
