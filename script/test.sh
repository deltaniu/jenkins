
#!/bin/bash

passwd='Rfvnji_0890'

/usr/bin/expect <<-EOF
set time 30
spawn rsync -avzP  ./build  root@140.143.132.159:/home/test
expect {
"*password:" {send "$passwd\r"} 
}
interact
expect eof
EOF

