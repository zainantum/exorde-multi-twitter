import requests
import sys, re, os, json
import docker
from subprocess import Popen, PIPE, STDOUT
import socket


client = docker.from_env()

def send_to_telegram(message):
    apiURL = os.environ['BOT_URL']
    try:
        response = requests.post(apiURL, data={'info': message})
        print(response.text)
    except Exception as e:
        print(e)


def check_rep(name, file):
    host = socket.gethostname()
    tw_mail = ""
    print("Checking "+name+" container")
    dkg = client.containers.get(name).logs(stream = True, follow = False, tail=500)
    try:
        list_rep_found = []
        while True:
            line = next(dkg).decode("utf-8")
            if "INFO:root:        twitter" in line:
                tail = line.split("|")
                list_rep_found.append(tail[-1])
            if "INFO:root:       [Twitter] Email provided =" in line:
                tail = line.split("=")
                tw_mail = tail[-1]
    except StopIteration:
        print(f'log stream ended for '+name)   

    totrep = list_rep_found[-1].replace(" ","")
    with open(file, 'r') as openfile:
        json_object = json.load(openfile)
    if totrep != json_object["rep"]:
        send_to_telegram("Total rep from "+str(host)+" server ["+name+"] "+str(tw_mail)+": "+str(totrep))
        dictionary = {
            "rep": totrep
        }
        with open(file, "w") as outfile:
            json.dump(dictionary, outfile)
    else:
        send_to_telegram("Total rep from "+str(host)+" server ["+name+"] "+str(tw_mail)+" rate limited, change container: "+str(totrep))
    


get_con = client.containers.list(filters={"status":"running", "name":"exorde1"})
if(len(get_con) == 1):
    check_rep("exorde1","rep1.json")
    
get_con = client.containers.list(filters={"status":"running", "name":"exorde2"})
if(len(get_con) == 1):
    check_rep("exorde2","rep2.json")
