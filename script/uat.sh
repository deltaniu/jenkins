#!/usr/bin/expect

foreach root {
    /home/test/
    }{
        spawn rsync -avzP -e "ssh   -o stricthostkeychecking=no"  ./build/   root@140.143.132.159:$root
        expect "root@$root's password:"
        send "Rfvnji_0890\r"
        interact
        puts "$root done"
}
puts 'done'
exit
