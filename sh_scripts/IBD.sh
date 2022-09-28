#!/bin/bash

###################################################################
#Script Name	: binarize.sh                                                                                            
#Description	: Computes IBD in .bed data across all subjects                                                                          
#Args           : None                                                                                           
#Author       	: Vicente Peris Sempere                                                
#Email         	: vipese@stanford.edu                                        
###################################################################

# Get directories
GWASDATA=$(jq -r .plinkFiles.GWAS settings.json)
IBDGEN=$(jq -r .file.IBDGenome settings.json)
PREFIX=$(jq -r '.plinkFiles.prefix' settings.json)

# Compute IBD
./bin/plink --bfile ${GWASDATA}${PREFIX} --genome --out $IBDGEN

