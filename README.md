# Urbanization affects circulating stress hormones but not brain receptor expression in a songbird

Data and R code for:

> Fossett, T.E., Lane, S.J., VanDiest, I.J., Gilbert, E.R., Sewall, K.B. Urbanization affects circulating stress hormones but not brain receptor expression in a songbird. *Submitted to General and Comparative Endocrinology.*

Sewall Lab, Department of Biological Sciences, Virginia Tech. Contact: Kendra Sewall (ksewall@vt.edu)

## Study overview

We compared baseline plasma corticosterone (2017 cohort) and hippocampal (Hp) and hypothalamic (HYPO) mineralocorticoid receptor (MR) and glucocorticoid receptor (GR) mRNA expression (2022 cohort) between urban and rural song sparrow (*Melospiza melodia*) nestlings in southwestern Virginia, USA. Nests parasitized by brown-headed cowbirds were excluded from analyses.

## Files

| File | Description |
|---|---|
| `Nestling.CORT.2017.csv` | 2017 cohort: nestling morphometrics and baseline plasma corticosterone (ng/mL) |
| `Nestling_CORT_2017.Rmd` | Analysis of baseline corticosterone by habitat (LMM) and original panel figures |
| `Fig1_combined.R` | Produces manuscript Fig. 1 (panels a and b combined) |
| `2022_Nestling_MR_GR_qPCR_data.csv` | 2022 cohort: qPCR Ct values for MR and GR (with ACTB reference gene values), ΔCt, ΔΔCt, relative quantity (RQ), and nestling morphometrics |
| `2022_Nestlings_HYPO_HP_MR_GR.Rmd` | Analysis of MR and GR expression by habitat, brain region, and age (LMM) and figures |

## Key variables

**Nestling.CORT.2017.csv**
- `NID` – nest ID; `Habitat` – Urban or Rural; `Site` – study site
- `Day` – nestling age (days post-hatch); `Date` – sampling date
- `Baseline cort` – baseline plasma corticosterone (ng/mL)
- `bhco.nestling` – whether the nest contained a brown-headed cowbird nestling (only "no" used in analyses)
- Morphometrics: `Mass` (g), `Tarsus Average`, `Wingchord average`, pin/feather lengths (mm)

**2022_Nestling_MR_GR_qPCR_data.csv**
- `SAMPLE` – sample ID; `Nest.id` – nest ID; `Treatment`/`Habitat` – Urban or Rural
- `GENE.x` – target gene (MR or GR); `brain.region` – Hp (hippocampus) or HYPO (hypothalamus)
- `CT`, `CT.MEAN`, `CT.SD` – target gene cycle threshold (duplicate wells)
- `actb._C`, `actb.mean`, `actb.SD` – ACTB reference gene Ct
- `delta.ct` = target Ct − ACTB Ct; `dd.ct` = ΔCt − mean ΔCt of rural birds (calibrator); `RQ` = 2^(−ΔΔCt)
- `Age` – nestling age (days post-hatch); `Date` – collection date; `Cowbird` – brood parasitism (only "No" used)
- Morphometrics: `Mass` (g), tarsus, wing chord, bill, pin and feather measurements (mm; five replicate measures and averages)

## Notes

- In `2022_Nestling_MR_GR_qPCR_data.csv`, `SAMPLE` IDs are region-specific (HY-n = hypothalamus, HP-n = hippocampus of the same nestling); the .Rmd derives a nestling ID (`SAMPLE.ID`) from the shared number for the individual random effect.
- Analyses were run in R v4.6.0 with lme4, lmerTest, emmeans, performance, and ggplot2 (see package calls at the top of each .Rmd).
- Place all files in one folder (or open them within an R project) so the relative file paths resolve.

## License

Data and code are released under the [Creative Commons Attribution 4.0 International License (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/). Please cite the associated article when using these data.
