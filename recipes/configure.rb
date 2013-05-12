# Example config file
#files:
#  - /var/log/httpd/access_log
#  - /var/log/httpd/error_log
#  - /opt/misc/*.log
#  - /var/log/mysqld.log
#  - /var/run/mysqld/mysqld-slow.log
#hostname: www42   # override OS hostname
#parse_fields: syslog   # predefined regex name or double-quoted regex
#exclude_patterns:
#  - exclude this
#  - \d+ things
#destination:
#  host: logs.papertrailapp.com
#  port: 12345   # optional, defaults to 514

template "/etc/log_files.yml" do
  source "log_files.erb"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[remote_syslog]"
  variables :yaml => {
              'files'            => node.remote_syslog.conf.files,
              'exclude_files'    => node.remote_syslog.exclude_files,
              'hostname'         => node.remote_syslog.hostname,
              'parse_fields'     => node.remote_syslog.parse_fields,
              'prepend'          => node.remote_syslog.prepend,
              'exclude_patterns' => node.remote_syslog.exclude_patterns,
              'destination'      => node.remote_syslog.destination
            }.to_yaml(:SortKeys => true).split("\n").map{|l| l.gsub(/ \!ruby.*$/, "").gsub(/---/, "")}.join("\n")

end
