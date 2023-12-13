rm -rf watch.py* && wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/watch.py?token=GHSAT0AAAAAACHQUDN2ETEG3LH67UT5E2LSZLZOTOQ && chmod +x watch.py
wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/rep1.json?token=GHSAT0AAAAAACHQUDN2CMOJMHX3QKYMO53SZLZOVOA
wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/rep2.json?token=GHSAT0AAAAAACHQUDN3PMNZI3PL27S4A4USZLZOVWA
echo -e "\e[1m\e[32m1. Installing watcher... \e[0m" && sleep 2
pathFileRestart=$(realpath watch.py)
if ! crontab -l | grep -q 'watch.py';
then
    echo "Adding auto watch script to cronjob"
    crontab -l > mycron
    echo "*/30 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
