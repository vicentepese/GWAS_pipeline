#!/bin/bash 

# Get directories, files and resources
GWASBIN=$(jq -r '.directory.GWAS_binaries' settings.json)
GWAS=$(jq -r '.plinkFiles.GWAS' settings.json)
MERGELIST=$(jq -r '.file.mergeList' settings.json)
COMMONSNPS=$(jq -r '.file.commonSNPs' settings.json)
PREFIX=$(jq -r '.plinkFiles.prefix' settings.json)

# Get list of files 
BINFILES=$(find $GWASBIN -iname '*.bim' -type f -exec sh -c 'printf "%s\n" "${0%.*}"' {} ';'| head -1)

# Get number of files to merge 
NUMFILES=$(awk 'END{print NR}' $MERGELIST)

# If more than one dataset, merge and filter - else, filter
if [ $NUMFILES -lt 1 ];
then 
    plink --bfile $BINFILES \
    --merge-list $MERGELIST \
    --extract $COMMONSNPS \
    --allow-no-sex \
    --memory 4626791360 \
    --make-bed \
    --out ${GWAS}$PREFIX > ${GWAS}$PREFIX
else
    cp $BINFILES.bed ${GWAS}$PREFIX.bed
    cp $BINFILES.fam ${GWAS}$PREFIX.fam
    cp $BINFILES.bim ${GWAS}$PREFIX.bim
fi

