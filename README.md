
# nf-core/fetchngs2rnaseq

Prototype for importing entire nf-core pipelines as subworkflows in a meta-pipeline. This repository contains a meta-pipeline for [fetchngs](https://github.com/nf-core/fetchngs) -> [rnaseq](https://github.com/nf-core/rnaseq).

Notes:

- Both `fetchngs` and `rnaseq` have been set up to better supporting importing (currently on `dev` branch), by moving code from the `bin` and `lib` directories into modules and subworkflows.

- An `nf-core pipelines` command is needed to import top-level workflow from the pipeline repository (instead of `nf-core/modules`).

  - Should import the top-level workflow (e.g. `NFCORE_FETCHNGS`) and workflows from `workflows` directory (e.g. `SRA`)

  - All dependent subworkflows and modules should also be installed

  - The `bin` and `lib` directories should either be moved into modules (as described above) or the nf-core CLI could copy these directories, though file name conflicts are likely

- nf-core boilerplate can be added through the nf-core CLI as usual, some manual curation is required

- Module config will be moved into the modules with https://github.com/nextflow-io/nextflow/pull/4510, other config is standard boilerplate with some manual edits (e.g. test profiles)

- Pipeline params could be automatically merged by nf-core CLI with some manual curation to handle name conflicts
