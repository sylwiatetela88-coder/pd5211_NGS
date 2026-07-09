nextflow.enable.dsl=2

process FASTQC {
    tag "$sample_id"
    publishDir "results/qc/fastqc", mode: 'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    path "*_fastqc.{html,zip}", emit: fastqc_out

    script:
    """
    fastqc ${reads}
    """
}

process MULTIQC {
    tag "all_samples"
    publishDir "results/qc/multiqc", mode: 'copy'

    input:
    path fastqc_files

    output:
    path "multiqc_report.html", emit: multiqc_html
    path "multiqc_data", emit: multiqc_data

    script:
    """
    multiqc .
    """
}
-
workflow {
    // 1. Tworzenie kanału wejściowego z par odczytów z folderu data/
    read_pairs_ch = Channel.fromFilePairs('data/*_{1,2}.fastq.gz')

    // 2. Uruchomienie kontroli jakości dla każdej próbki z osobna
    FASTQC(read_pairs_ch)

    // 3. Zebranie wszystkich raportów za pomocą .collect() i przekazanie ich do MultiQC
    MULTIQC(FASTQC.out.fastqc_out.collect())
}