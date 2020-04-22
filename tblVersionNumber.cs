namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblVersionNumber")]
    public partial class tblVersionNumber
    {
        [Key]
        [StringLength(10)]
        public string Version_Number { get; set; }
    }
}
