#!/bin/bash



printf "\t\e[1;33m  ▄▄        ▄  ▄▄       ▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄       ▄▄  ▄▄       ▄▄  \e[0m\n"
printf "\t\e[1;33m ▐░░▌      ▐░▌▐░░▌     ▐░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌     ▐░░▌▐░░▌     ▐░░▌ \e[0m\n"
printf "\t\e[1;33m ▐░▌░▌     ▐░▌▐░▌░▌   ▐░▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌▐░▌░▌   ▐░▐░▌▐░▌░▌   ▐░▐░▌ \e[0m\n"
printf "\t\e[1;33m ▐░▌▐░▌    ▐░▌▐░▌▐░▌ ▐░▌▐░▌▐░▌       ▐░▌▐░▌       ▐░▌          ▐░▌▐░▌▐░▌ ▐░▌▐░▌▐░▌▐░▌ ▐░▌▐░▌ \e[0m\n"
printf "\t\e[1;33m ▐░▌ ▐░▌   ▐░▌▐░▌ ▐░▐░▌ ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌          ▐░▌▐░▌ ▐░▐░▌ ▐░▌▐░▌ ▐░▐░▌ ▐░▌ \e[0m\n"
printf "\t\e[1;33m ▐░▌  ▐░▌  ▐░▌▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌ ▄▄▄▄▄▄▄▄▄█░▌▐░▌  ▐░▌  ▐░▌▐░▌  ▐░▌  ▐░▌ \e[0m\n"
printf "\t\e[1;33m ▐░▌   ▐░▌ ▐░▌▐░▌   ▀   ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░░░░░░░░░░░▌▐░▌   ▀   ▐░▌▐░▌   ▀   ▐░▌ \e[0m\n"
printf "\t\e[1;33m ▐░▌    ▐░▌▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌▐░▌       ▐░▌ \e[0m\n"
printf "\t\e[1;33m ▐░▌     ▐░▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░▌       ▐░▌ \e[0m\n"
printf "\t\e[1;33m ▐░▌      ▐░░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌ \e[0m\n"
printf "\t\e[1;33m  ▀        ▀▀  ▀         ▀  ▀         ▀  ▀            ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀         ▀  \e[0m\n"
printf "\t\e[1;31m https://github.com/maaaaz/nmaptocsv \e[0m\n"  
printf "\t\e[1;31m          |By @Ano_F_| \e[0m\n"                                                                                         




read -e -p $'\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Nmap output file -oN: \e[0m' nmapoutput

python nmaptocsv.py -i $nmapoutput -f ip-port-service-version -d ',' -o nmap2csv.csv
for ip in $(cat nmap2csv.csv |grep -v "IP"| awk -F '"' '{print $2}'| sort -u | uniq)
do
    echo -e "$ip\n\t" >>mm.csv
    for port in $(cat nmap2csv.csv | grep "$ip" | awk -F '"' '{print $4}' | uniq)
    do
       for service in  $(cat nmap2csv.csv | grep "$ip" | grep "$port" | awk -F '"' '{print $6}'| uniq)
       do
            for version in $(cat nmap2csv.csv | grep "$ip" | grep "$port" | grep "$service" | awk -F '"' '{print $8}' | uniq|tr " " "-" )
            do
                echo -e "\t$port\n\t\t$service\n\t\t\t$version\n" >>mm.csv
                
            done
       done
    done
done
echo -e  "\t\e[1;31m $(pwd) \e[0m\n"
echo -e "\n\e[1;31m[\e[0m\e[1;77m*\e[0m\e[1;31m] Output is saved $(pwd)/mm.csv \e[0m"

#creating Array for ip addresses
#ips=()

# creating XML File
# mindmapname="bash-mindmap"
# echo '<map version="1.0.1">' >> output.mm
# echo '<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->' >> output.mm
# echo '<node CREATED="1615708819295" ID="ID_784420366" MODIFIED="1615708825737" TEXT="$mindmapname">' >> output.mm


# for ip in $(cat csv.csv |grep -v "IP"| awk -F '"' '{print $2}'| sort -u | uniq)
# do
#     echo "<node CREATED='1615708833554' ID='ID_574753714' MODIFIED='1615708839610' POSITION='right' TEXT='$ip'>" >> output.mm
#     for port in $(cat csv.csv | grep $ip | awk -F '"' '{print $4}')
#     do
#        ips+=("$ip")
#        for service in  $(cat csv.csv | grep $ip | grep $port | awk -F '"' '{print $6}')
#        do
#             for version in $(cat csv.csv | grep $ip | grep "$port" | grep $service | awk -F '"' '{print $8}'| tr " " "-")
#             do
#                 echo "<node CREATED='1615708842395' ID='ID_1082146847' MODIFIED='1615708844818' TEXT='$port'>" >> output.mm
#                 echo "<node CREATED='1615708845686' ID='ID_994753929' MODIFIED='1615708849379' TEXT='$service'>" >> output.mm
#                 echo "<node CREATED='1615708850164' ID='ID_796642628' MODIFIED='1615708851582' TEXT='$version'/>">> output.mm
#                 echo '</node>' >> output.mm
#                 echo '</node>' >> output.mm
#                 if [[ " ${ips[-1]} " -eq " $ip " ]]; then
#                     echo "</node>" >> output.mm
#                 else
#                     continue
#                 fi
#             done
#        done
#     done
# done

# echo "</node>">> output.mm
# echo "</node>">> output.mm
# echo '</map>' >> output.mm