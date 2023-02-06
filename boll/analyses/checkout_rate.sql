select * 
from {{ metrics.calculate(
    metric('checkout_rate')
) }}