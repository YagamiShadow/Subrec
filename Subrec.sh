
#!/bin/bash

#insert ascci subrec
#insert colors
echo -e "${orange}[+]
╭━━━╮╱╱╭╮
┃╭━╮┃╱╱┃┃
┃╰━━┳╮╭┫╰━┳━┳━━┳━━╮
╰━━╮┃┃┃┃╭╮┃╭┫┃━┫╭━╯
┃╰━╯┃╰╯┃╰╯┃┃┃┃━┫╰━╮
╰━━━┻━━┻━━┻╯╰━━┻━━╯${close}"
echo "[+]By: Nihilnomine"



url=$1
# sort -u is  by uniquie
# tr -d   removes the port numbers
#    echo $url > var; sed 's/https\?:\/\///g' var >> var1 strips the  chars
#    sed '1d' var1 | cut -d '/' -f 1 | tee var
#    ured="\e[1;31m"
yellow="\e[1;33m"
orange="\e[1;39m"
blue="\e[1;36m"
green="\e[1;32m"
close="\e[0m"

if [ ! -d "$url" ];then  #!=does not
	mkdir "-p" $url          # -p sets parent dir
fi                               #closes if statment

if [ ! -d "$url/recon" ];then 
	mkdir $url/recon
fi  

if [ ! -e "$url/recon/assets.txt" ]; then
        touch assets.txt	                         #touch=new file

fi

if [ ! -e "$url/recon/f.txt" ]; then
        touch f.txt
fi        

if [ ! -d "$url/recon/photos" ]; then
	mkdir $url/recon/photos
fi

echo -e "${blue}[+] Harvesting subdomains with  assetfinder...${close}"
assetfinder --subs-only $url >>  $url/recon/assets.txt
cat $url/recon/assets.txt | grep $1 >> $url/recon/final.txt
rm $url/recon/assets.txt

echo -e "${orange}[+] Harvesting subdomains with Amass...${close}"
amass enum -d $url >>  $url/recon.f.txt
sort -u  $url/recon/f.txt >> $url/recon/final.txt   #sorts the subs into the final text
rm $url/recon/f.txt

#to do
#to do
#to do
echo -e "${green}[+} Finding alive doimains with httpprobe...${close}"
cat $url/recon/final.txt | sort -u | httprobe -p https:443  | sed "s/https\?:\///" | tr "-d :443" >> $url/recon/alive.txt

echo -e "${yellow}[+] Taking ScreenShots with Gowitness...${close}"
gowitness single $url -o >> $url/recon/photos

#addeyewitness











#
#
#
#to do ,cat results ,word count, line count
# whatweb, built with, wayback,
