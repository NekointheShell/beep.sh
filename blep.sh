#!/usr/bin/env bash


wget_exists=false
curl_exists=false
fortune_exists=false
cowsay_exists=false
lolcat_exists=false
figlet_exists=false


look_for_tooling () {
    which -s wget > /dev/null 2>&1; if [ $? -eq 0 ]; then wget_exists=true; fi
    which -s curl > /dev/null 2>&1; if [ $? -eq 0 ]; then curl_exists=true; fi
    which -s fortune > /dev/null 2>&1; if [ $? -eq 0 ]; then fortune_exists=true; fi
    which -s cowsay > /dev/null 2>&1; if [ $? -eq 0 ]; then cowsay_exists=true; fi
    which -s lolcat > /dev/null 2>&1; if [ $? -eq 0 ]; then lolcat_exists=true; fi
    which -s figlet > /dev/null 2>&1; if [ $? -eq 0 ]; then figlet_exists=true; fi
}


main () {
    image_exists=false

    if [ $wget_exists == 'true' ]; then
        wget https://blep.sh/blep.png -O /tmp/blep.png
    elif [ $curl_exists == 'true' ]; then
        curl -s https://blep.sh/blep.png -o /tmp/blep.png
    fi

    if [ -f /tmp/blep.png ]; then image_exists=true; fi

    if [ figlet_exists == 'true' ] && [ lolcat_exists == 'true' ]; then
        figlet BLEP | lolcat
    elif [ figlet_exists == 'true' ]; then
        figlet BLEP
    fi

    if [ fortune_exists == 'true' ] && [ cowsay_exists == 'true' ] && [ lolcat_exists == 'true' ]; then
        fortune | cowsay | lolcat
    elif [ fortune_exists == 'true' ] && [ cowsay_exists == 'true']; then
        fortune | cowsay
    elif [ fortune_exists == 'true' ]; then
        fortune
    fi

    if [ image_exists ]; then
        which -s open > /dev/null 2>&1; if [ $? -eq 0 ]; then open /tmp/blep.png; fi
        which -s eog > /dev/null 2>&1; if [ $? -eq 0 ]; then eog /tmp/blep.png; fi
        which -s eom > /dev/null 2>&1; if [ $? -eq 0 ]; then eom /tmp/blep.png; fi
        which -s shotwell > /dev/null 2>&1; if [ $? -eq 0 ]; then shotwell /tmp/blep.png; fi
        which -s ristretto > /dev/null 2>&1; if [ $? -eq 0 ]; then ristretto /tmp/blep.png; fi
        which -s firefox > /dev/null 2>&1; if [ $? -eq 0 ]; then firefox file:///tmp/blep.png; fi
        which -s chrome > /dev/null 2>&1; if [ $? -eq 0 ]; then chrome file:///tmp/blep.png; fi
        which -s chromium > /dev/null 2>&1; if [ $? -eq 0 ]; then chromium file:///tmp/blep.png; fi
        if [ -f /Applications/Firefox.app/Contents/MacOS/firefox ]; then /Applications/Firefox.app/Contents/MacOS/firefox file:///tmp/blep.png; fi
    fi
}


look_for_tooling
main
