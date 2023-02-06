select * 
from {{ metrics.calculate(
    metric('product_view_rate')
) }}