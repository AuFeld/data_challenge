select * 
from {{ metrics.calculate(
    metric('add_to_cart_rate')
) }}