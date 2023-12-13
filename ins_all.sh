read -p "Enter your chatid: " chatid
rm -rf watch_all.py* && wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/watch_all.py && chmod +x watch_all.py
wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/rep1.json
wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/rep2.json
sed -i -e "s|replace_chatid*|$chatid|" watch_all.py
echo -e "\e[1m\e[32m1. Installing watcher... \e[0m" && sleep 2
pathFileRestart=$(realpath watch_all.py)
if ! crontab -l | grep -q 'watch_all.py';
then
    echo "Adding auto watch script to cronjob"
    crontab -l > mycron
    echo "*/30 * * * * python3 $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo "Install library"
pip install docker
echo '=============== DONE ==================='
