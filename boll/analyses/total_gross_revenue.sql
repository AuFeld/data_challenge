select * 
from {{ metrics.calculate(
    metric('total_gross_revenue')
) }}
