# nhanes-mini-analysis
Self-directed R analysis of NHANES 2017–2018: vigorous work activity and obesity in adults aged 20 and over.

## Data
NHANES 2017–2018 (CDC), files DEMO_J, BMX_J and PAQ_J. Run `analysis.R` to download them into a `data` folder.

## Methods
I merged the three files by participant ID, kept adults aged 20 and over with a valid BMI and a yes or no answer on vigorous work activity (PAQ605), and defined obesity as BMI ≥ 30. I used logistic regression, adjusted for age and sex.

## Finding
In this unweighted analysis of NHANES 2017–2018 adults, those who reported vigorous work activity had higher odds of obesity than those who did not (OR 1.44, 95% CI 1.26–1.65), after adjusting for age and sex. Men had lower odds of obesity than women (OR 0.78, 95% CI 0.70–0.88), and age showed no clear association.

## Limitations
This variable measures vigorous activity at work and not exercise for health, so the result may reflect occupation and related factors, such as income and education, which I did not adjust for. The design is cross-sectional, so it cannot show cause. The analysis is unweighted, so the results describe this sample and not the US population.

## Next steps
To use recreational activity and the survey weights to give better confidence intervals.
