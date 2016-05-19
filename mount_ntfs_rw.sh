#****************************************************
#  Filename: mount_ntfs_rw.sh
#  Version: 1.0
#  Author: Leon(weippt.com)
#  Last modified: 2016-05-17 21:39
#  Description: 针对于Mac和U盘(NTFS格式)连接后不能修改和创建文件的情况，此脚本可自动以读写模式挂载移动设备
#  使用方法：1: 插上U盘或移动硬盘
#            2: 打开Mac系统下的终端应用
#            3: 拖放此文件到终端
#            4: 按"Enter"键执行脚本
#****************************************************

function ex_dir(){
    files=`ls /Volumes/`
    IFS=$(echo -en "\n\b")
    for file in $files
    do
        dev='null'
        ntfs=0
        mountis=0
        dinfo=`diskutil info /Volumes/${file}`
        for val in $dinfo
        do
            if [ `echo $val | grep -e 'Device Node:'` ];then
                #dev=`echo $val|cut -d " " -f 2`
                dev=`echo $val|awk -F ' ' '{print $3}'`
            fi
            if [ $dev = "null" ];then
                continue;
            fi
            if [ `echo $val | grep -e 'File System Personality:'` ] && [ `echo $val | grep -e 'NTFS'` ];then
                ntfs=1
            fi
            if [ $ntfs -eq 1 ];then
                if [ `echo $val | grep -e 'Read-Only Media:'` ];then
                    yesno=`echo $val|awk -F ' ' '{print $3}'`
                    if [ $yesno = 'Yes' ];then
                        echo -e '您的移动设备[ \033[01;31m'${file}'\033[00m ]是只读系统，无法挂载为读写系统';
                        break;
                    fi
                    continue;
                fi
                if [ `echo $val | grep -e 'Read-Only Volume:'` ];then
                    yesno=`echo $val|awk -F ' ' '{print $3}'`
                    if [ $yesno = 'No' ];then
                        echo -e '您的移动设备已挂载为读写模式，设备名: \033[01;31m'${file}'\033[00m';
                        break;
                    fi
                    mountis=1
                fi
                #mount
                if [ $mountis -eq 0 ];then
                    continue;
                fi
                #check sudo
                x=`echo "" | sudo -S ls > /dev/null 2>&1`
                if [ $? -eq 1 ];then
                    echo -e '\033[01;31m 请输入您当前登陆用户的密码: \033[00m';
                fi

                sudo umount /Volumes/${file}
                mdir=/Volumes/${file}_rw_leon
                if [ ! -d $mdir ];then
                    sudo mkdir $mdir
                fi
                sudo mount_ntfs -o rw,nobrowse $dev $mdir
                #ln -s $mdir ~/Desktop/${file}
                echo -e '您的移动设备[ \033[01;31m'${file}'\033[00m ]已挂载为读写模式';
                open $mdir
                break;
            fi
        done
    done
}

ex_dir

echo -e '\033[01;05m 设置可写操作已完成 \033[00m';
echo ''
echo '打开设备请执行: open /Volumes/[Device Name]'
echo '弹出设备请执行: sudo umount /Volumes/[Device Name]';
echo ''
echo '如果您的设备名称包含空格，空格前需添加符号"\"，如[Device\ Name] !'
