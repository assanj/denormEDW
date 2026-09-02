SQL Error [22012]: ERROR: division by zero
  Where: SQL statement "SELECT 
                    COALESCE(SUM(s / v_k1_curr[v_i]), 0), -- Сумма S / K1
                    COALESCE(SUM(v), 0)                   -- Сумма V
                                                 FROM temp_matrix
                WHERE "Месяц действия" = v_action_month
                  AND "Месяц календарный" = v_calendar_month"
PL/pgSQL function glm_calc_main() line 141 at SQL statement
SQL statement "SELECT actuary.glm_calc_main()"
PL/pgSQL function glm_calc_all() line 108 at PERFORM
SQL statement "SELECT actuary.glm_calc_all()"
PL/pgSQL function glm_run_all() line 16 at PERFORM
  ERROR: division by zero
  Where: SQL statement "SELECT 
                    COALESCE(SUM(s / v_k1_curr[v_i]), 0), -- Сумма S / K1
                    COALESCE(SUM(v), 0)                   -- Сумма V
                                                 FROM temp_matrix
                WHERE "Месяц действия" = v_action_month
                  AND "Месяц календарный" = v_calendar_month"
PL/pgSQL function glm_calc_main() line 141 at SQL statement
SQL statement "SELECT actuary.glm_calc_main()"
PL/pgSQL function glm_calc_all() line 108 at PERFORM
SQL statement "SELECT actuary.glm_calc_all()"
PL/pgSQL function glm_run_all() line 16 at PERFORM
