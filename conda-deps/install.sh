##without bedtools
conda create -n addCDStoTransGTF-deps python=3.10.4 bioconda::ucsc-fasize bioconda::borf bioconda::gffread bioconda::gff3sort -y  

## with bedtools
conda create -n addCDStoTransGTF-deps python=3.10.4 bioconda::ucsc-fasize bioconda::borf bioconda::gffread bioconda::gff3sort bioconda::bedtools=2.31 -y

exit

OR:


conda env create -f my-env.yml

where my-env.yml is one of the following files:
- addCDStoTransGTF-deps.linux.with-bedtools.yml
- addCDStoTransGTF-deps.linux.without-bedtools.yml
- addCDStoTransGTF-deps.MacOS-M4max.with-bedtools.yml
- addCDStoTransGTF-deps.MacOS-M4max.without-bedtools.yml
