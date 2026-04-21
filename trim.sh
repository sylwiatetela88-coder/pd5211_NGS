#!/bin/bash
SAMPLES=("SRR25629154" "SRR25629153")
for ID in "${SAMPLES[@]}"
do
	echo "Przetwarzanie próbki: $ID"
	trimmomatic SE -threads 4 -phred33 \
	${ID}.fastq.gz \
	 ${ID}_trimmed.fastq.gz \
	LEADING:20 TRAILING:20 SLIDINGWINDOW:5:20 MINLEN:50
	echo "Zakończono przetwarzanie $ID"
done
