select * 
from {{ metrics.calculate(
    metric('total_line_item_order_units')
) }}