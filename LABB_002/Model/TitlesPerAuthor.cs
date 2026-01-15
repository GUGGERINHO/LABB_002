using System;
using System.Collections.Generic;

namespace LABB_002.Model;

public partial class TitlesPerAuthor
{
    public string Name { get; set; } = null!;

    public string? Age { get; set; }

    public string? Titles { get; set; }

    public string? InventoryValue { get; set; }
}
