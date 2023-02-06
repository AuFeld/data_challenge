select * 
from {{ metrics.calculate(
    metric('conversion_rate')
) }}