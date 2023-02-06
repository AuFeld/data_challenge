select * 
from {{ metrics.calculate(
    metric('signup_rate')
) }}