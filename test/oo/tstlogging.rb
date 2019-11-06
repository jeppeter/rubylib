

$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

load "logging.rb"

Logging.baseconfig(50, "\#{datetime} \#{msg}\n")
Logging.add_stdout(false)
Logging.add_file('new.log', false)
Logging.add_file('app.log', true)

Logging.fatal "call first"
Logging.error "call first"
Logging.warn "call first"
Logging.info "call first"
Logging.debug "call first"

Logging.add_stdout(false)
Logging.add_file('new.log', false)
Logging.add_file('app.log', true)

Logging.baseconfig(20,"\#{serv} \#{datetime} \#{msg}\n")
Logging.fatal "call second"
Logging.error "call second"
Logging.warn "call second"
Logging.info "call second"
Logging.debug "call second"

idx = 0
while idx < ARGV.length 
	l = Logging.create(ARGV[idx])
	l.baseconfig(50,"\#{datetime} \#{msg}\n")
	l.add_stdout(true)
	l.fatal(4,"call %s first", ARGV[idx])
	l.error(4,"call %s first", ARGV[idx])
	l.warn(4,"call %s first", ARGV[idx])
	l.info(4,"call %s first", ARGV[idx])
	l.debug(4,"call %s first", ARGV[idx])
	idx += 1
end
