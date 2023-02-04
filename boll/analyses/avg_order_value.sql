select * 
from {{ metrics.calculate(
    metric('average_order_value')
) }}
