# Blood pressure before and after: an R learning project

**Simulated data | Base R | Reproducible analysis**

An educational project prepared for the research portfolio of Tanura Akter Lima. It demonstrates a basic analysis workflow relevant to interests in exercise physiology and blood pressure regulation.

## Question

How can paired systolic blood pressure measurements be checked, summarised and visualised using R?

## Data and provenance

The script generates 40 fictional participant records using `set.seed(2027)`. Before measurements follow a normal distribution with mean 138 and standard deviation 12 mmHg. After measurements equal before values plus a simulated change with mean -5 and standard deviation 6 mmHg. Measurements are rounded to one decimal place.

The average reduction is an assumption built into the simulation. There was no exercise intervention, no recruitment and no patient dataset. The distributions were selected for demonstration and were not fitted to a clinical study.

## Workflow

1. Generate and save simulated data, then import the CSV.
2. Check columns, numeric types, unique IDs and missing values.
3. Calculate change as after minus before.
4. Summarise means and sample standard deviations.
5. Plot paired measurements and the distribution of change.
6. Save a results report and R environment information.

## Results

See the [generated results and summary table](outputs/RESULTS.md).

![Paired blood pressure measurements](outputs/bp_before_after.png)

## Reproduce

Install R. No extra packages are required. Open `blood-pressure-r-demo.Rproj` in RStudio and source `analysis.R`, or run the following from this folder:

```sh
Rscript analysis.R
```

The script recreates the simulated CSV and outputs. It overwrites only its named generated files. The recorded R version is in `outputs/session_info.txt`.

## Data dictionary

| Variable | Meaning | Unit |
|---|---|---|
| participant_id | Fictional participant identifier | None |
| sbp_before | Simulated before measurement | mmHg |
| sbp_after | Simulated after measurement | mmHg |
| change | Derived after minus before; calculated in the script | mmHg |

The saved source CSV contains the first three columns; change is derived after import.

## Interpretation and limitations

The results describe invented data. They cannot demonstrate that exercise reduces blood pressure or predict an individual's response. A real uncontrolled before-and-after study would also require attention to measurement error, regression to the mean, medication changes and confounding. This project does not model those features or ACE genotype. It makes no clinical recommendations.

## Assistance and authorship

This initial project was created with AI assistance at the applicant's request. It is a learning demonstration, not a claim of independent programming proficiency or original clinical research. The applicant should review, run and understand the code before discussing it with a prospective supervisor.

## Next development

Extend the workflow to an appropriately licensed public health dataset, document its source and missing data, and define the research question before analysing associations.
