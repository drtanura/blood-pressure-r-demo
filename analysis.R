# SIMULATED blood pressure analysis. Educational use only.
# Run from the project directory: Rscript analysis.R
# Requires only base R and the recommended packages shipped with R.

set.seed(2027)
dir.create('data', showWarnings = FALSE)
dir.create('outputs', showWarnings = FALSE)

n <- 40L
bp <- data.frame(participant_id = seq_len(n),
                 sbp_before = round(rnorm(n, 138, 12), 1))
# An average reduction is imposed by design, not discovered from patients.
bp$sbp_after <- round(bp$sbp_before + rnorm(n, -5, 6), 1)
write.csv(bp, 'data/simulated_bp.csv', row.names = FALSE)

# Import the saved CSV to demonstrate a complete file-based workflow.
bp <- read.csv('data/simulated_bp.csv')
required <- c('participant_id', 'sbp_before', 'sbp_after')
stopifnot(all(required %in% names(bp)), nrow(bp) == n,
          !anyDuplicated(bp$participant_id), !anyNA(bp),
          all(vapply(bp, is.numeric, logical(1))))
bp$change <- bp$sbp_after - bp$sbp_before
stopifnot(isTRUE(all.equal(bp$change, bp$sbp_after - bp$sbp_before)))

summary_table <- data.frame(
  measurement = c('Before', 'After', 'Change: after minus before'),
  n = rep(nrow(bp), 3),
  mean_mmHg = round(c(mean(bp$sbp_before), mean(bp$sbp_after), mean(bp$change)), 2),
  sd_mmHg = round(c(sd(bp$sbp_before), sd(bp$sbp_after), sd(bp$change)), 2))
write.csv(summary_table, 'outputs/summary_table.csv', row.names = FALSE)
write.csv(data.frame(variable = names(bp), missing = colSums(is.na(bp))),
          'outputs/data_checks.csv', row.names = FALSE)

png('outputs/bp_before_after.png', width = 1500, height = 1000, res = 160)
par(mar = c(5, 5, 5, 2))
matplot(c(1, 2), t(as.matrix(bp[c('sbp_before', 'sbp_after')])),
        type = 'b', pch = 16, lty = 1,
        col = adjustcolor('#337C96', alpha.f = 0.35), xaxt = 'n',
        xlab = 'Measurement', ylab = 'Systolic blood pressure (mmHg)',
        main = 'Blood pressure before and after')
axis(1, at = 1:2, labels = c('Before', 'After'))
lines(1:2, c(mean(bp$sbp_before), mean(bp$sbp_after)),
      col = '#BA4735', lwd = 4, type = 'b', pch = 18)
mtext('SIMULATED DATA | 40 fictional participants | Educational demonstration',
      side = 3, line = 0.5, cex = 0.8)
legend('topright', c('Fictional participant', 'Group mean'),
       col = c('#337C96', '#BA4735'), lty = 1, lwd = c(1, 4), bty = 'n')
invisible(dev.off())

png('outputs/change_distribution.png', width = 1500, height = 1000, res = 160)
hist(bp$change, breaks = 9, col = '#337C96', border = 'white',
     main = 'Distribution of simulated within-person change',
     xlab = 'After minus before (mmHg)')
abline(v = 0, lty = 2, lwd = 2, col = '#BA4735')
mtext('Negative values indicate lower follow-up measurements; simulated data only.',
      side = 3, line = 0.3, cex = 0.8)
invisible(dev.off())
capture.output(sessionInfo(), file = 'outputs/session_info.txt')

rows <- apply(summary_table, 1, function(x) paste0('| ', paste(x, collapse = ' | '), ' |'))
report <- c('# Results: simulated blood pressure analysis', '',
            '**Educational demonstration. No real participants or clinical evidence.**', '',
            '| Measurement | n | Mean (mmHg) | SD (mmHg) |',
            '|---|---:|---:|---:|', rows, '',
            '![Paired measurements](bp_before_after.png)', '',
            '![Distribution of change](change_distribution.png)', '',
            'An average reduction was built into the simulation. These results reflect',
            'that assumption and cannot establish a health benefit from exercise.', '',
            'All 40 participant IDs are unique and all analysed values are non-missing.',
            'Negative change means a lower after measurement. Individual changes vary.', '',
            'No hypothesis test is used: statistical significance from invented data',
            'would not provide evidence about a real intervention.')
writeLines(report, 'outputs/RESULTS.md')
print(summary_table)
cat('\nCompleted. Outputs saved in outputs/.\n')
