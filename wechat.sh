#!/bin/bash
##
#
CorpID="ww655b1d98f2f13ec9"            #我的企业下面的CorpID
Secret="DGKZg-XGAdlpKtXo1vHLL5-rSbb1HE9YwceAiOS5JEA"            #创建的应用那有Secret
GURL="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$CorpID&corpsecret=$Secret"
Token=$(/usr/bin/curl -s -G $GURL |awk -F\": '{print $4}'|awk -F\" '{print $2}')
#echo $Token
PURL="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=$Token"
 
function body(){
        local int agentid=1000002   #改为AgentId 在创建的应用那里看
        local UserID=$1                 #发送的用户位于$1的字符串
        local PartyID=1                 #第一步看的通讯录中的部门ID
        local Msg=$(echo "$@" | cut -d" " -f3-)
        printf '{\n'
        printf '\t"touser": "'"$UserID"\"",\n"
        printf '\t"toparty": "'"$PartyID"\"",\n"
        printf '\t"msgtype": "text",\n'
        printf '\t"agentid": "'"$agentid"\"",\n"
        printf '\t"text": {\n'
        printf '\t\t"content": "'"$Msg"\""\n"
        printf '\t},\n'
        printf '\t"safe":"0"\n'
        printf '}\n'
}
/usr/bin/curl --data-ascii "$(body $1 $2 $3)" $PURL
