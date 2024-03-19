#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { NFCORE_FETCHNGS         } from './workflows/nfcore_fetchngs'
include { NFCORE_RNASEQ           } from './workflows/nfcore_rnaseq'
include { PIPELINE_INITIALISATION } from './subworkflows/local/utils_nfcore_fetchngs_pipeline'
include { PIPELINE_COMPLETION     } from './subworkflows/local/utils_nfcore_rnaseq_pipeline'

workflow {

    main:

    //
    // SUBWORKFLOW: Run initialisation tasks
    //
    PIPELINE_INITIALISATION (
        params.version,
        params.help,
        params.validate_params,
        params.monochrome_logs,
        args,
        params.outdir,
        params.input,
        params.ena_metadata_fields
    )

    //
    // WORKFLOW: Run main workflow
    //
    NFCORE_FETCHNGS (
        PIPELINE_INITIALISATION.out.ids
    )
    NFCORE_RNASEQ (
        NFCORE_FETCHNGS.out.samplesheet
    )

    //
    // SUBWORKFLOW: Run completion tasks
    //
    PIPELINE_COMPLETION (
        "nextflow_schema.json",
        params.email,
        params.email_on_fail,
        params.plaintext_email,
        params.outdir,
        params.monochrome_logs,
        params.hook_url,
        NFCORE_RNASEQ.out.multiqc_report
    )
}
