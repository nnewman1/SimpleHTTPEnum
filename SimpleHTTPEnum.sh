#!/bin/bash

url=$1

if [ ! -d "$url" ];then
        mkdir $url
fi

if [ ! -d "$url/recon" ];then
        mkdir $url/recon
fi

echo "[+] Harvesting subdomains with assetfinder..."
assetfinder $url >> $url/recon/assetFinder.txt
echo "[+] Created TargetURL/recon/assetFinder.txt..."
cat $url/recon/assetFinder.txt | grep $1 >> $url/recon/assetFinder_SubDomains.txt
echo "[+] Created TargetURL/recon/assetFinder_SubDomains.txt..."

echo "[+] Harvesting subdomains with Amass..."
amass enum -d $url >> $url/recon/aMass.txt
echo "[+] Created TargetURL/recon/aMass.txt..."
sort -u $url/recon/aMass.txt >> $url/recon/aMass_SubDomains.txt
echo "[+] Created TargetURL/recon/aMass_SubDomains.txt..."

echo "[+] Probing for alive domains with assestFinder_SubDomains.txt..."
cat $url/recon/assetFinder_SubDomains.txt | sort -u | httprobe >> $url/recon/alive_assetFinder_SubDomains.txt
echo "[+] Created TargetURL/recon/alive_assetFinder_SubDomains.txt..."

echo "[+] Probing for alive domains with aMass_SubDomains.txt..."
cat $url/recon/aMass_SubDomains.txt | sort -u | httprobe >> $url/recon/alive_aMass_SubDomains.txt
echo "[+] Created TargetURL/recon/alive_aMass_SubDomains.txt..."

