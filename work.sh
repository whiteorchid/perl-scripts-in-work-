#!/bin/bash

#for i in `ls *txt`;do `dos2unix $i`;done ### windows 下编辑的，需要转换格式
#perl m.pl dof1M.txt dof1M.txt.xls  
#perl i.pl dof1I.txt dof1I.txt.xls
#perl d.pl dof1D.txt dof1D.txt.xls
############################################
perl m2.pl dof1M.txt dof1M.txt2.xls
sed -i  -e 's/Sample//g' -e 's/(1)//g' dof1M.txt2.xls

#############################
perl i2.pl dof1I.txt dof1I.txt2.xls
sed -i  -e 's/Sample//g' -e 's/(1)//g' dof1I.txt2.xls 

############################
perl d2.pl dof1D.txt dof1D.txt2.xls
sed -i  -e 's/Sample//g' -e 's/(1)//g' dof1D.txt2.xls

