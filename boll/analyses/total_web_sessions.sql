select * 
from {{ metrics.calculate(
    metric('total_web_sessions')
) }}