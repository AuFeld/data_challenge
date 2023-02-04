select * 
from {{ metrics.calculate(
    metric('total_bounced_web_sessions')
) }}