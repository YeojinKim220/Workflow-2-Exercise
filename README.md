# Workflow-2-Exercise

# Yeojin Kim

Pipeline using Nextflow

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

# Get Started

- Genome Assembly: skesa

```sh
conda create -n nextflow -c conda-forge -c bioconda -c defaults mlst
conda install -c bioconda skesa nextflow -y
conda install -c bioconda numpy matplotlib pysam -y
conda install -c bioconda hmmer prodigal pplacer -y
pip3 install checkm-genome

mkdir -pv ./checkm/{asm,db,checkm_output}
cd ./checkm/db
wget https://zenodo.org/records/7401545/files/checkm_data_2015_01_16.tar.gz
tar zxvf checkm_data_2015_01_16.tar.gz
echo 'export CHECKM_DATA_PATH=/path/to/my_checkm_data' >> ~/.bashrc 
source ~/.bashrc
echo "${CHECKM_DATA_PATH}"
```

```sh
nextflow main.nf --reads1 raw_data/F0582884_R1.fastq.gz --reads2 raw_data/F0582884_R2.fastq.gz
```



