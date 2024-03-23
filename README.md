
# nf-core/fetchngs2rnaseq

Prototype for importing entire nf-core pipelines as subworkflows in a meta-pipeline. This repository contains a meta-pipeline for [fetchngs](https://github.com/nf-core/fetchngs) -> [rnaseq](https://github.com/nf-core/rnaseq).

Notes:

- Both `fetchngs` and `rnaseq` have been set up to better support importing (currently on `dev` branch), by moving code from the `bin` and `lib` directories into modules and subworkflows.

  These two pipelines can be improved further by separating the saving/loading to/from published files from the "core" workflows, which should take and emit channels of files with metadata.

- An `nf-core pipelines` command is needed to import top-level workflow from the pipeline repository (instead of `nf-core/modules`).

  - Should import the top-level workflow (e.g. `NFCORE_FETCHNGS`) and workflows from `workflows` directory (e.g. `SRA`)

  - All dependent subworkflows and modules should also be installed

  - The `bin` and `lib` directories should either be moved into modules (as described above) or the nf-core CLI could copy these directories, though file name conflicts are likely

- nf-core boilerplate can be added through the nf-core CLI as usual, some manual curation is required

- Module config will be moved into the modules with https://github.com/nextflow-io/nextflow/pull/4510, other config is standard boilerplate with some manual edits (e.g. test profiles)

- Pipeline params could be automatically merged by nf-core CLI with some manual curation to handle name conflicts

- The `fromSamplesheet` channel factory in the `nf-validation` plugin should be refactored into an operator that accepts a channel of samplesheet files:

  ```groovy
  // standard usage with param
  Channel.fromPath(params.input) | fromSamplesheet

  // custom input channel
  ch_samplesheet | fromSamplesheet
  ```

- nf-core currently distinguishes between `workflows` and `subworkflows`. However, from Nextflow's perspective they are the same. It might be simpler to just have `workflows` and within that, `nf-core` workflows which are installed from `nf-core/modules` and `local` workflows which are maintained locally (and can be installed via the `nf-core pipelines` command described above).
