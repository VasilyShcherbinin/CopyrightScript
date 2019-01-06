#!/usr/bin/env bash

shopt -s expand_aliases
unset IFS

folderPath=$1
copyrightType=$2
copyrightMode=$3
removeFlag=$4
year=$(date +%Y)
counter=0

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    alias sed="sed -i"
elif [[ "$unamestr" == 'Darwin' ]]; then 
    alias sed="sed -i ''"
fi

copyrightLicensed='\
######################################## {COPYRIGHT-TOP} ###\
#Insert copyright here
################################################ {COPYRIGHT-END} ###'

copyrightConfidential='\
################################## {COPYRIGHT-TOP} ###\
#Insert copyright here
############################################# {COPYRIGHT-END} ###'

findExistingCopyright()
{
  counter=$((counter+1))
  echo -ne "$counter files in $folderPath have been processed" \\r

  if (head -1 $1| grep -q '// *Exception that you dont want to copyright*')
  then
    echo "File $1 does not need copyright - skipping"
    continue
  fi

  if [[ "$1" =~ .*\.sh$ ]] ;then
    alias findCopyrightStart="head -2 $1| grep -q '{COPYRIGHT-TOP}') && (head -30 $1| grep -q '{COPYRIGHT-END}'"
  elif [[ "$1" =~ .*\.html$ ]] ;then
    alias findCopyrightStart="head -2 $1| grep -q '{COPYRIGHT-TOP}') && (head -30 $1| grep -q '{COPYRIGHT-END}'"
  else 
    alias findCopyrightStart="head -1 $1| grep -q '{COPYRIGHT-TOP}') && (head -30 $1| grep -q '{COPYRIGHT-END}'"
  fi

  if ($findCopyrightStart)
  then
    if [ "$removeFlag" = "r" ]; then
        if [[ "$i" =~ .*\.html$ ]] ;then
            sed '/<!--start/,/end-->/d' $1
        else
            sed '/{COPYRIGHT-TOP}/,/{COPYRIGHT-END}/d' $1
        return 0
        fi
    elif [ "$removeFlag" = "" ]; then
        echo "File $1 has copyright - skipping"
        continue
    fi
    return 1
  fi
}

copyrightLicensedSlash=${copyrightLicensed//#///}
copyrightConfidentialSlash=${copyrightConfidential//#///}

if [ "$copyrightMode" = "all" ] ;then
    for i in $(find $folderPath -type f);do
        case "$copyrightType" in
        linc)   if [[ "$i" =~ .*\.sh$ ]] ;then
                    findExistingCopyright $i
                    sed "2i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.go$ ]] || [[ "$i" =~ .*\.ts$ ]] || [[ "$i" =~ .*\.js$ ]]  ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensedSlash" $i
                fi
                if [[ "$i" =~ .*\.yml$ ]] || [[ "$i" =~ .*\.yaml$ ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ "Makefile" ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.html$ ]] ;then
                    findExistingCopyright $i
                    if [[ "$(head -n 1 $i)" == "<!DOCTYPE html>" ]] ;then
                        sed "2iend-->" $i
                        sed "2i<!--start$copyrightLicensed" $i
                    else
                        sed "1iend-->" $i
                        sed "1i<!--start$copyrightLicensed" $i
                    fi
                fi                ;;
        conf)   if [[ "$i" =~ .*\.sh$ ]] ;then
                    findExistingCopyright $i
                    sed "2i$copyrightConfidential" $i
                fi
                if [[ "$i" =~ .*\.go$ ]] || [[ "$i" =~ .*\.ts$ ]] || [[ "$i" =~ .*\.js$ ]]  ;then
                    findExistingCopyright $i
                    sed "1i$copyrightConfidentialSlash" $i
                fi
                if [[ "$i" =~ .*\.yml$ ]] || [[ "$i" =~ .*\.yaml$ ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightConfidential" $i
                fi
                if [[ "$i" =~ "Makefile" ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightConfidential" $i
                fi
                if [[ "$i" =~ .*\.html$ ]] ;then
                    findExistingCopyright $i
                    if [[ "$(head -n 1 $i)" == "<!DOCTYPE html>" ]] ;then
                        sed "2iend-->" $i
                        sed "2i<!--start$copyrightConfidential" $i
                    else
                        sed "1iend-->" $i
                        sed "1i<!--start$copyrightConfidential" $i
                    fi
                fi
                ;;
        auto)   if [[ "$i" =~ .*\.sh$ ]] ;then
                    findExistingCopyright $i
                    sed "2i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.yml$ ]] || [[ "$i" =~ .*\.yaml$ ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.go$ ]] || [[ "$i" =~ .*\.ts$ ]] || [[ "$i" =~ .*\.js$ ]]  ;then
                    findExistingCopyright $i
                    sed "1i$copyrightConfidentialSlash" $i
                fi
                if [[ "$i" =~ "Makefile" ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.html$ ]] ;then
                    findExistingCopyright $i
                    if [[ "$(head -n 1 $i)" == "<!DOCTYPE html>" ]] ;then
                        sed "2iend-->" $i
                        sed "2i<!--start$copyrightLicensed" $i
                    else
                        sed "1iend-->" $i
                        sed "1i<!--start$copyrightLicensed" $i
                    fi
                fi
                ;;
        *)      echo "Please enter proper copyright type."
                exit
        esac
    done
elif [ "$copyrightMode" = "" ] ;then
    for i in $(find $folderPath -maxdepth 1 -type f);do
        case "$copyrightType" in
        linc)   if [[ "$i" =~ .*\.sh$ ]] ;then
                    findExistingCopyright $i
                    sed "2i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.go$ ]] || [[ "$i" =~ .*\.ts$ ]] || [[ "$i" =~ .*\.js$ ]]  ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensedSlash" $i
                fi
                if [[ "$i" =~ .*\.yml$ ]] || [[ "$i" =~ .*\.yaml$ ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ "Makefile" ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.html$ ]] ;then
                    findExistingCopyright $i
                    if [[ "$(head -n 1 $i)" == "<!DOCTYPE html>" ]] ;then
                        sed "2iend-->" $i
                        sed "2i<!--start$copyrightLicensed" $i
                    else
                        sed "1iend-->" $i
                        sed "1i<!--start$copyrightLicensed" $i
                    fi
                fi                ;;
        conf)   if [[ "$i" =~ .*\.sh$ ]] ;then
                    findExistingCopyright $i
                    sed "2i$copyrightConfidential" $i
                fi
                if [[ "$i" =~ .*\.go$ ]] || [[ "$i" =~ .*\.ts$ ]] || [[ "$i" =~ .*\.js$ ]]  ;then
                    findExistingCopyright $i
                    sed "1i$copyrightConfidentialSlash" $i
                fi
                if [[ "$i" =~ .*\.yml$ ]] || [[ "$i" =~ .*\.yaml$ ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightConfidential" $i
                fi
                if [[ "$i" =~ "Makefile" ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightConfidential" $i
                fi
                if [[ "$i" =~ .*\.html$ ]] ;then
                    findExistingCopyright $i
                    if [[ "$(head -n 1 $i)" == "<!DOCTYPE html>" ]] ;then
                        sed "2iend-->" $i
                        sed "2i<!--start$copyrightConfidential" $i
                    else
                        sed "1iend-->" $i
                        sed "1i<!--start$copyrightConfidential" $i
                    fi
                fi                ;;
        auto)   if [[ "$i" =~ .*\.sh$ ]] ;then
                    findExistingCopyright $i
                    sed "2i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.yml$ ]] || [[ "$i" =~ .*\.yaml$ ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.go$ ]] || [[ "$i" =~ .*\.ts$ ]] || [[ "$i" =~ .*\.js$ ]]  ;then
                    findExistingCopyright $i
                    sed "1i$copyrightConfidentialSlash" $i
                fi
                if [[ "$i" =~ "Makefile" ]] ;then
                    findExistingCopyright $i
                    sed "1i$copyrightLicensed" $i
                fi
                if [[ "$i" =~ .*\.html$ ]] ;then
                    findExistingCopyright $i
                    if [[ "$(head -n 1 $i)" == "<!DOCTYPE html>" ]] ;then
                        sed "2iend-->" $i
                        sed "2i<!--start$copyrightLicensed" $i
                    else
                        sed "1iend-->" $i
                        sed "1i<!--start$copyrightLicensed" $i
                    fi
                fi                ;;
        *)      echo "Please enter proper copyright type."
                exit
        esac
    done
fi

