select * 
from {{ metrics.calculate(
    metric('total_order_count')
) }}