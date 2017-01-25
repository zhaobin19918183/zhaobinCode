#coding=utf8
import urllib.request
import codecs
import time
import re
try:
    sid = '0'
    count = 0
    container = set()
    while True:
        time.sleep(3)
        myUrl = "http://g.hupu.com/node/playbyplay/matchLives?sid={0}&s_count={1}&match_id=152702&homeTeamName=%e7%81%ab%e7%ae%ad&awayTeamName=%e5%9b%bd%e7%8e%8b" 
        stream = urllib.request.urlopen(myUrl.format(sid, count))
        Reader = codecs.getreader("utf-8")
        fh = Reader(stream)
        pageData = fh.read()
        if not pageData:
            continue
        se = re.search(r"sid=\"\d+[.]*\d*", pageData)
        sid = se.group(0)[5:]
        lines = pageData.split('</tr>')
        lines.reverse()
        for line in lines:
            if line:
                lineSid = re.search(r"sid=\"\d+[.]*\d*", line).group(0)[5:]
                if lineSid in container:
                    continue
                container.add(lineSid)
                co = re.compile(r"<td width=\"\d+\">|<td width=\"\d+\" class=\"center\">|<tr sid=\"\d+[.]*\d*\">|<td colspan=\"\d+\" style=\"text-align:center\">|<tr sid=\"\d+\" class=\"pause\">")
                newline = co.sub('', line)
                newline = newline.replace('<td>', ' ').replace('</td>', ' ').replace('<b>', '*').replace('</b>', '*')
                print(newline)
                if newline.strip().endswith('比赛结束*'):
                    raise Exception()
        count = len(container)
except Exception as e:
    print(e)
finally:
    input("Please input any key to exit.")
