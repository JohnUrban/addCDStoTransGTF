# addCDStoTransGTF
returns a CDS-updated transcriptome GTF:: quickly annotate your transcriptome assembly GTF with coding sequence (CDS) coordinates corresponding to protein sequences predicted from the transcripts.


![logo](/img/logo.png)




	Usage: ../addCDStoTransGTF <gtf_file> <min_valid_orf_length> <genome_fasta>

		<gtf_file>:		This is an input GTF file of a transcriptome from StringTie, PsiClass, or other.
					It assumes column 3 contains the feature type (e.g. 'transcript' and 'exon').
					It assumes there are gene_id, transcript_id, and exon_number attributes.

		<min_valid_orf_length>:	Minimum valid ORF length (in AA) for Borf to consider an ORF as valid.
					Recommendation is 20-40 AA, 75 highest.
					 - Higher values give fewer false positive ORFs, but more false negatives.
					 - Shorter values give more false positive ORFs, but fewer false negatives.
					 - Using shorter values here still permits longer cutoffs to be used in downstream analyses,
					     with the advantage of allowing discovery of true short proteins using more sophisticated filtering methods (motifs, domains, etc).

		<genome_fasta>:		The genome FASTA file that corresponds to the GTF.

	Example Usage: 
		../addCDStoTransGTF my-transcriptome.gtf 40 my-genome.fasta

	GTF Support:
		addCDStoTransGTF supports any transcriptome GTF where transcript_id = gene_id.k where k is the transcript number.
		For example, it supports StringTie and PsiClass transcriptome GTFs. 

	What addCDStoTransGTF does:
		This script starts by extracting transcript sequences from the genome given the provided transcriptome GTF file.
		It then chooses the best ORF from the stranded transcript sequences using Borf.
		The corresponding protein and coding sequences are provided in FASTA files.
		It then maps the ORF (i.e. the Coding Sequence or CDS) coordinates from the transcript to the genome.
		Ultimately, the final product is the CDS-annotated transcriptome GTF that works with the provided genome FASTA file.

	What to do next:
		The CDS-annotated transcriptome GTF can be used visualization in genome browsers (e.g. IGV) or for further analysis.
		The CDS-annotated transcriptome GTF can be used to extract transcript, CDS, and protein sequences from the genome sequence.
		The learned protein sequences can be used for further functional annotation or analysis.

	Why use addCDStoTransGTF:
		Although addCDStoTransGTF does not replace more sophisticated annotation pipelines, it provides a quick way to predict protein sequences and add CDS information to transcriptome GTFs.
		addCDStoTransGTF is a good starting point for many analyses, especially when high-quality genome annotations are not available.
		So long as the transcriptome GTF is of high quality, the predicted CDS and proteins are usually of high quality as well.
		This "annotation" approach is simple and makes no assumptions about genes present other than what is in the user's transcriptome assembly to be analyzed.
		The CDS-annotated transcriptome GTF can be used for downstream analyses, such as differential expression analysis, functional annotation, or comparative genomics.

		addCDStoTransGTF is particularly useful for non-model organisms where gene models are not well established, although it has some perks even for model organisms.
		A strength is that, for downstream analyses such as differential expression, using the transcriptome GTF leaves both coding and non-coding genes as substrates for analysis.
		This is in contrast to genome annotation pipelines that often only focus on protein-coding genes.
		Although, some non-coding RNAs will be assigned ORFs that may not be biologically relevant (false positives), other pipelines often suffer from the opposite problem (false negatives).
		Common annotation pipelines often use an arbitrary thumb-rule, such as having no ORF longer than a minimum protein length parameter, to classify a transcript as non-coding.
		However, many transcripts classified as lncRNAs in public datasets have valid ORFs and real proteins (e.g. with signal peptides and other known motifs).
		Thus, by predicting the best ORF for transcripts that might otherwise be classified as lncRNA, addCDStoTransGTF offers higher sensitivity to normally-ignored ORFs.
		This allows the user to further characterize and filter predicted proteins with more sophisticated measures (e.g. motif, domain, and functional analyses).
		It also allows the user to enforce a minimum protein length rule further down the analysis chain if desired.

	Dependencies:
		This script is designed to be run in a conda environment with the necessary tools installed, such as gffread, faSize, borf, and gff3sort.pl.
		It also expects fastaFormatter.py and extractFastxEntries.py (supplied with this program).
		It also expects common utilities such as awk, grep, and md5sum or md5sum-lite to be installed in the PATH.
		If needed, make sure to activate the appropriate conda environment before running the script.

		For example, you can install the necessary tools in a conda environment named 'addCDStoTransGTF-deps' with the following command:
			conda create -n addCDStoTransGTF-deps python=3.10.4 bioconda::ucsc-fasize bioconda::borf bioconda::gffread bioconda::gff3sort -y 

		Then run:
			conda activate addCDStoTransGTF-deps

		There are also YML files for conda environments provided for Linux and MacOS, named addCDStoTransGTF-deps.linux.yml and addCDStoTransGTF-deps.MacOS-M4max.yml, respectively.

		To install the conda environment from the YML file, use the following command:
			conda env create -f addCDStoTransGTF-deps.linux.yml

		Then run:
			conda activate addCDStoTransGTF-deps


