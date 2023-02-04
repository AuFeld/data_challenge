select * 
from {{ metrics.calculate(
    metric('bounce_rate')
) }}