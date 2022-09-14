#! /bin/sh

echo "각기 다른 문자의 조합 수"
echo "각기 다른 문자의 조합 수" >> $HOSTNAME-result.txt 2>&1
MINCLASS=`grep minclass /etc/security/pwquality.conf | grep -v "^#" | awk '{ print $3 }'`
if [ $MINCLASS ] ; then
   if [ $MINCLASS -eq 3 ] ; then
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호" 
   else 
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약"      
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi


echo "연속으로 같은 문자의 사용 허용"
echo "연속으로 같은 문자의 사용 허용" >> $HOSTNAME-result.txt 2>&1
MAXREPEAT=`grep maxrepeat /etc/security/pwquality.conf | grep -v "^#" | awk '{ print $3 }'`
if [ $MAXREPEAT ] ; then
   if [ $MAXREPEAT -ge 0 ] ; then
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호" 
   else 
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약"      
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi


echo "연속으로 같은 종류의 사용 허용"
echo "연속으로 같은 종류의 사용 허용" >> $HOSTNAME-result.txt 2>&1
MAXCLASSREPEAT=`grep maxclassrepeat /etc/security/pwquality.conf | grep -v "^#" | awk '{ print $3 }'`
if [ $MAXCLASSREPEAT ] ; then
   if [ $MAXCLASSREPEAT -ge 0 ] ; then
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호" 
   else 
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약"      
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi


echo "로그인 실패 시 차단 설정"
echo "로그인 실패 시 차단 설정" >> $HOSTNAME-result.txt 2>&1
DENY=`cat /etc/pam.d/system-auth | grep -v "^#" | awk '{ print $4 }' | grep deny=5`
UNLOCK_TIME=`cat /etc/pam.d/system-auth | grep -v "^#" | awk '{ print $5}' | grep unlock_time=300`
if [ $DENY ] ; then
   if [ $UNLOCK_TIME ] ; then
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호"
      echo " " >> $HOSTNAME-result.txt 2>&1
   else
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약"
      echo " " >> $HOSTNAME-result.txt 2>&1
   fi
else
   echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약"
   echo " " >> $HOSTNAME-result.txt 2>&1
fi


echo "Session Timeout 설정" 
echo "Session Timeout 설정" >> $HOSTNAME-result.txt 2>&1

if [ -f /etc/profile ] ; then
   echo "" >> $HOSTNAME-result.txt 2>&1
else
	echo "/etc/profile 파일이 없습니다." >> $HOSTNAME-result.txt 2>&1
fi
if [ -f /etc/csh.login ] ; then
   echo "" >> $HOSTNAME-result.txt 2>&1
else
	echo "/etc/csh.login 파일이 없습니다."  >> $HOSTNAME-result.txt 2>&1
fi

if [ -f /etc/profile ] ; then
	if [ `cat /etc/profile | grep -v "#" | egrep 'TMOUT|TIMEOUT' | grep -v '[0-9]600' | grep '600$' | wc -l ` -eq 1 ] ; then
		echo "[RESULT]양호"
		echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
		echo " "  >> $HOSTNAME-result.txt 2>&1
	else
		if [ -f /etc/csh.login ] ; then
			if [ `cat /etc/csh.login  | grep -v "#" | egrep 'autologout' | grep -v '[0-9]10' | grep '10$' | wc -l ` -eq 1 ] ; then
				echo "[RESULT]양호"
				echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
				echo " " >> $HOSTNAME-result.txt 2>&1
			else
				echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
				echo " " >> $HOSTNAME-result.txt 2>&1
			fi
		else
			echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
			echo " " >> $HOSTNAME-result.txt 2>&1
		fi
	fi
else
	if [ -f /etc/csh.login  ] ; then
		if [ `cat /etc/csh.login  | grep -v "#" | egrep 'autologout' | grep -v '[0-9]10' | grep '10$' | wc -l ` -eq 1 ] ; then
			echo "[RESULT]양호"
			echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
			echo " " >> $HOSTNAME-result.txt 2>&1
		else 
			echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
			echo " " >> $HOSTNAME-result.txt 2>&1
		fi
	else 
		echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
		echo " " >> $HOSTNAME-result.txt 2>&1
	fi
fi  

echo "패스워드 최대 사용 기간 설정"
echo "패스워드 최대 사용 기간 설정" >> $HOSTNAME-result.txt 2>&1
PASSMAXDAYS=`grep PASS_MAX_DAYS /etc/login.defs | grep -v "^#" | awk '{ print $2 }'`
if [ $PASSMAXDAYS ] ; then
   if [ $PASSMAXDAYS -gt 90 ] ; then 
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약" 
   else 
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호" 
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi

echo "패스워드 최소 사용 기간 설정"
echo "패스워드 최소 사용 기간 설정" >> $HOSTNAME-result.txt 2>&1
PASSMINDAYS=`grep PASS_MIN_DAYS /etc/login.defs | grep -v "^#" | awk '{ print $2 }'`
if [ $PASSMINDAYS ] ; then
   if [ $PASSMINDAYS -ge 1 ] ; then 
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호"
   else 
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약"       
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi

echo "패스워드 만료 경고일 설정"
echo "패스워드 만료 경고일 설정" >> $HOSTNAME-result.txt 2>&1
PASSWARNAGE=`grep PASS_WARN_AGE /etc/login.defs | grep -v "^#" | awk '{ print $2 }'`
if [ $PASSWARNAGE ] ; then
   if [ $PASSWARNAGE -eq 7 ] ; then
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호"  
   else 
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약" 
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi


echo "패스워드 최소길이 설정"
echo "패스워드 최소길이 설정" >> $HOSTNAME-result.txt 2>&1
PASSMINLEN=`grep PASS_MIN_LEN /etc/login.defs | grep -v "^#" | awk '{ print $2 }'`
if [ $PASSMINLEN ] ; then
   if [ $PASSMINLEN -gt 7 ] ; then
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호"  
   else 
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약" 
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi


echo "사용자 계정의 UID 범위"
echo "사용자 계정의 UID 범위" >> $HOSTNAME-result.txt 2>&1
UID_MIN=`grep UID_MIN /etc/login.defs | grep -v "^#" | awk '/1000/{ print $2 }'`
UID_MAX=`grep UID_MAX /etc/login.defs | grep -v "^#" | awk '/60000/{ print $2 }'`
if [[ $UID_MIN ]] && [[ $UID_MAX ]] ; then
   if [ $UID_MIN -eq 1000 ] ; then
      if [ $UID_MAX -eq 60000 ] ; then
         echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
         echo " " >> $HOSTNAME-result.txt 2>&1
         echo "[RESULT]양호" 
      else
         echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
         echo " " >> $HOSTNAME-result.txt 2>&1
         echo "[RESULT]취약"
      fi
   else
      echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약(설정값이 없습니다.)"
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi


echo "시스템 계정의 UID 범위"
echo "시스템 계정의 UID 범위" >> $HOSTNAME-result.txt 2>&1
SYS_UID_MIN=`grep UID_MIN /etc/login.defs | grep -v "^#" | awk '/201/{ print $2 }'`
SYS_UID_MAX=`grep UID_MAX /etc/login.defs | grep -v "^#" | awk '/999/{ print $2 }'`
if [[ $SYS_UID_MIN ]] && [[ $SYS_UID_MAX ]] ; then
   if [ $SYS_UID_MIN -eq 201 ] ; then
      if [ $SYS_UID_MAX -eq 999 ] ; then
         echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
         echo " " >> $HOSTNAME-result.txt 2>&1
         echo "[RESULT]양호"
      else
         echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
         echo " " >> $HOSTNAME-result.txt 2>&1
         echo "[RESULT]취약"
      fi
   else
      echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약(설정값이 없습니다.)"
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi 


echo "사용자 계정의 GID 범위"
echo "사용자 계정의 GID 범위" >> $HOSTNAME-result.txt 2>&1
GID_MIN=`grep GID_MIN /etc/login.defs | grep -v "^#" | awk '/1000/{ print $2 }'`
GID_MAX=`grep GID_MAX /etc/login.defs | grep -v "^#" | awk '/60000/{ print $2 }'`
if [[ $GID_MIN ]] && [[ $GID_MAX ]] ; then
   if [ $GID_MIN -eq 1000 ] ; then
      if [ $GID_MAX -eq 60000 ] ; then
         echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
         echo " " >> $HOSTNAME-result.txt 2>&1
         echo "[RESULT]양호" 
      else
         echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
         echo " " >> $HOSTNAME-result.txt 2>&1
         echo "[RESULT]취약"
      fi
   else
      echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약(설정값이 없습니다.)"
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi


echo "시스템 계정의 GID 범위"
echo "시스템 계정의 GID 범위" >> $HOSTNAME-result.txt 2>&1
SYS_GID_MIN=`grep GID_MIN /etc/login.defs | grep -v "^#" | awk '/201/{ print $2 }'`
SYS_GID_MAX=`grep GID_MAX /etc/login.defs | grep -v "^#" | awk '/999/{ print $2 }'`
if [[ $SYS_GID_MIN ]] && [[ $SYS_GID_MAX ]] ; then
   if [ $SYS_GID_MIN -eq 201 ] ; then
      if [ $SYS_GID_MAX -eq 999 ] ; then
         echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
         echo " " >> $HOSTNAME-result.txt 2>&1
         echo "[RESULT]양호"
      else
         echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
         echo " " >> $HOSTNAME-result.txt 2>&1
         echo "[RESULT]취약"
      fi
   else
      echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약(설정값이 없습니다.)"
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi 


echo "사용자 계정 삭제시 그룹 삭제 여부"
echo "사용자 계정 삭제시 그룹 삭제 여부" >> $HOSTNAME-result.txt 2>&1
USERGROUPSENAB=`grep USERGROUPS_ENAB /etc/login.defs | grep -v "^#" | awk '{ print$2 }'`
if [ $USERGROUPSENAB ] ; then
   if [ $USERGROUPSENAB == 'yes' ] ; then
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호" 
   else
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약"
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi


echo "암호화 기법 설정"
echo "암호화 기법 설정" >> $HOSTNAME-result.txt 2>&1
ENCRYPTMETHOD=`grep ENCRYPT_METHOD /etc/login.defs | grep -v "^#" | awk '{ print$2 }'`
if [ $ENCRYPTMETHOD ] ; then
   if [ $ENCRYPTMETHOD == 'SHA512' ] ; then
      echo "[RESULT]양호" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]양호"
   else
      echo "[RESULT]취약" >> $HOSTNAME-result.txt 2>&1
      echo " " >> $HOSTNAME-result.txt 2>&1
      echo "[RESULT]취약"
   fi
else
   echo "[RESULT]취약(설정값이 없습니다.)" >> $HOSTNAME-result.txt 2>&1
   echo " " >> $HOSTNAME-result.txt 2>&1
   echo "[RESULT]취약(설정값이 없습니다.)"
fi








