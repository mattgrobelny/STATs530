#!/usr/bin/perl

$ENV{'PATH'} = "/home/mgrobelny/Downloads/EIG-6.1.4/bin/:$ENV{'PATH'}"; 
# MUST put smartpca bin directory in path for smartpca.perl to work

$command = "smartpca.perl";
$command .= " -i qcd.geno ";
$command .= " -a qcd.snp ";
$command .= " -b qcd.ind " ;
$command .= " -k 3 ";
$command .= " -o qcd.pca ";
$command .= " -p qcd.plot ";
$command .= " -e qcd.eval ";
$command .= " -l qcd.log ";
$command .= " -m 5 ";
$command .= " -t 3 ";
$command .= " -s 6.0 ";
print("$command\n");
system("$command");
