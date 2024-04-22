#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.reads1 = 'raw_data/F0582884_R1.fastq.gz'
params.reads2 = 'raw_data/F0582884_R2.fastq.gz'
params.checkm_input = './checkm/asm/'
params.checkm_output = './checkm/checkm_output/'
params.threads = 128

process skesa {
    input:
    path reads1
    path reads2
    val num_thread

    output:

    path "skesa_assembly.fna", emit: asm

    script:
    """
    skesa --reads ${reads1} ${reads2} --cores ${num_thread} --contigs_out skesa_assembly.fna 1> skesa.stdout.txt 2> skesa.stderr.txt
    """
    }

process checkm {
    input:
    file assembly
    path checkm_input
    path checkm_output
    val num_thread

    script:
    """
    cp ${assembly} ${checkm_input}
    checkm lineage_wf --reduced_tree -t ${num_thread} ${checkm_input} ${checkm_output} 
    """
}

process mlst{
    conda 'bioconda::mlst'
    input:
    file assembly

    script:
    """
    mlst ${assembly} > mlst.tsv
    """

}

workflow {
    reads1_ch = file(params.reads1)
    reads2_ch = file(params.reads2)
    checkm_input = file(params.checkm_input)
    checkm_output = file(params.checkm_output)
    
    num_threads = params.threads

    main: 
        skesa(reads1_ch, reads2_ch, num_threads)
        checkm(skesa.out.asm, checkm_input, checkm_output, num_threads)
        mlst(skesa.out.asm)
        }