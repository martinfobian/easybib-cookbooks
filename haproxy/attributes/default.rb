default["haproxy"]             = {}
default["haproxy"]["errorloc"] = {
  "400" => "400.http",
  "403" => "403.http",
  "408" => "408.http",
  "500" => "5xx.http",
  "502" => "5xx.http",
  "503" => "5xx.http",
  "504" => "5xx.http"
}

default["haproxy"]["ctl"] = {}
default["haproxy"]["ctl"]["version"] = "1.1.0"
default["haproxy"]["ctl"]["base_path"] = "/usr/local/share"
default["haproxy"]["log_dir"] = "/mnt/var/log/haproxy"
