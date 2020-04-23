namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblVPStandardReport
    {
        [Key]
        [Column(Order = 0)]
        public int Report_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(100)]
        public string Report_Name { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(100)]
        public string Report_Template { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(100)]
        public string Report_SP { get; set; }

        [StringLength(100)]
        public string Report_Additional_SP { get; set; }

        [Key]
        [Column(Order = 4)]
        public bool DateTo { get; set; }

        [Key]
        [Column(Order = 5)]
        public bool DateFrom { get; set; }
    }
}
