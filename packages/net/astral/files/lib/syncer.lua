local posix = require 'posix'

local pid = posix.fork()
  if pid == 0 then
     while true do
       posix.sleep(120)
       os.execute("/usr/lib/astral/gate-utils.sh sync_hosts > /dev/null 2>&1")
       os.execute("/usr/lib/astral/gate-utils.sh generate_config > /dev/null 2>&1")
       os.execute("/sbin/start-stop-daemon -p /var/run/astral-tincd.pid -s HUP -K > /dev/null 2>&1")
     end
  else
     local ouf = assert(io.open("/var/run/astral-syncer.pid", "w"))
     ouf:write(tostring(pid))
  end
