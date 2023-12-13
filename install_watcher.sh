rm -rf watch.py* && wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/watch.py && chmod +x watch.py
wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/rep1.json
wget https://raw.githubusercontent.com/zainantum/exorde-multi-twitter/main/rep2.json
echo -e "\e[1m\e[32m1. Installing watcher... \e[0m" && sleep 2
pathFileRestart=$(realpath watch.py)
if ! crontab -l | grep -q 'watch.py';
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
