pip3 install gym 1>/dev/null
pip3 install keras-rl 1>/dev/null


chmod +x Reinforcement_Learning-101-challenge/scripts/install_ngrok.sh
chmod +x Reinforcement_Learning-101-challenge/scripts/install_novnc.sh

bash Reinforcement_Learning-101-challenge/scripts/install_ngrok.sh 1>/dev/null
bash Reinforcement_Learning-101-challenge/scripts/install_novnc.sh 1>/dev/null

mkdir /content/models/

cat <<EoF>/usr/local/bin/run
#!/bin/bash
python3 Reinforcement_Learning-101-challenge/display_cartpole.py \$1
EoF

chmod +x /usr/local/bin/run