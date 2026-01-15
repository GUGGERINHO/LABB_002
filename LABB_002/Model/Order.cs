using System;
using System.Collections.Generic;

namespace LABB_002.Model;

public partial class Order
{
    public int Id { get; set; }

    public int CustomerId { get; set; }

    public DateOnly OrderDate { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
