- awk
```
awk 'NR == FNR { if(FNR >= 1 && FNR <= 6) { patch = patch $0 ORS }; next } FNR == 20 { $0 = patch $0 } 1' gitignore.txt text

# delete duplicate line 
awk '!seen[$0]++' text > text
```

- sed
```
sed -n 1,20p gitignore.txt>patch ;sed -i 20rpatch text

# eof: "\$aTEXTTOEND"
sed -i -e "$aTEXTTOEND"r<(sed '1,6!d' gitignore.txt) patch


# delete last 6 lines from the end
sed -i -n -e :a -e '1,6!{P;N;D;};N;ba' patch

head -n -6 text

n=6
tac text | sed "1,$n{d}" | tac
```

- count lines in file
```
wc -l file

awk 'END{print NR}' file

sed -n '$=' file (GNU sed)

grep -c ".*" file
```

- String
```
# current dir name
${PWD##*/}

# current dir name strip special characters
string=${PWD##*/}
string_strip=${string//[-._]/}
```

- rsync
```
# DOCKERCENTOS_PATH /var/www/html/dockercentos
rsync -avz --exclude-from /var/www/html/dockercentos/docker-centos/exclude.txt /var/www/html/dockercentos/docker-centos/* /var/www/html/dockercentos/
sed -i -e "$aTEXTTOEND"r<(sed '1,8!d' /var/www/html/dockercentos/docker-centos/gitignore.txt) /var/www/html/dockercentos/.gitignore
```