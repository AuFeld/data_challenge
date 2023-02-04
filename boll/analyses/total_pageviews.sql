select * 
from {{ metrics.calculate(
    metric('total_pageviews')
) }}