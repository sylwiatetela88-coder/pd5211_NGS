#!/bin/bash
REF="Ecoli_reference.fasta"
echo "Przetwarzam replikę 2..."
bcftools mpileup -Ou -f $REF Ecoli_rep2_fixmate_sorted.bam | bcftools call -mv -Ou -o variants_2.vcf
echo "Przetwarzam replikę 3..." 
bcftools mpileup -Ou -f $REF Ecoli_rep3_fixmate_sorted.bam  | bcftools call -mv -Ou -o variants_3.vcf
echo "Zakończono!"
