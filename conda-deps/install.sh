#
#conda create -n addCDStoTransGTF-deps bioconda::ucsc-fasize bioconda::borf bioconda::gffread bioconda::gff3sort -y


conda create -n addCDStoTransGTF-deps python=3.10.4 bioconda::ucsc-fasize bioconda::borf bioconda::gffread bioconda::gff3sort -y  


exit

OR:
conda env create -f addCDStoTransGTF-deps.linux.yml       
conda env create -f addCDStoTransGTF-deps.MacOS-M4max.yml
