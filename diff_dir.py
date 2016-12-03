import os
import sys

def exdir(d1, d2):
    fsdiff = []
    f1empty = []
    f2empty = []
    for parent,dirs,files in os.walk(d1):
        if files:
            for fs in files:
                res = diff_fs(os.path.join(parent,fs), d2)
                if res[0] == 2:
                    fsdiff.append('%s --- %s'%(res[1],res[2]))
                if res[0] == 3:
                    f2empty.append(res[1])
    for parent,dirs,files in os.walk(d2):
        if files:
            for fs in files:
                res = diff_fs(os.path.join(parent,fs), d1)
                if res[0] == 3:
                    f1empty.append(res[1])
    print '-------------- [Diff] %s : %s --------------'%(d1,d2)
    for p in fsdiff:
        print p
    print '-------------- [Empty] %s --------------'%d1
    for p in f1empty:
        print p
    print '-------------- [Empty] %s --------------'%d2
    for p in f2empty:
        print p

def diff_fs(f1, d2, empty=0):
    f1Arr = f1.split('/', 1)
    f2 = os.path.join(d2, f1Arr[1])
    if os.path.exists(f2):
        if empty:
            return [1, 1]
        md5 = os.popen('md5sum %s'%f1).readlines()
        md5Arr = md5[0].split(' ')
        f1md5 = md5Arr[0]
        md5 = os.popen('md5sum %s'%f2).readlines()
        md5Arr = md5[0].split(' ')
        f2md5 = md5Arr[0]
        
        if f1md5 == f2md5:
            return [1, 1]
        else:
            return [2, f1, f2]
    else:
        return [3,f1]

args = len(sys.argv)
if args<3:
    print 'Usage:'
    print '   python x.py dir1 dir2 []'
    print ''
    exit()

exdir(sys.argv[1], sys.argv[2])
