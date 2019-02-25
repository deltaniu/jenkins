
#!/bin/bash

passwd='xxx'

/usr/bin/expect <<-EOF
set time 30
spawn rsync -avzP  ./build  root@xxxxxx:/home/test
expect {
"*password:" {send "$passwd\r"} 
}
interact
expect eof
EOF

