namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblVPReview
    {
        [Key]
        public int Review_ID { get; set; }

        public int BDApp_ID { get; set; }

        public int BDApp_Number { get; set; }

        [Column(TypeName = "date")]
        public DateTime Review_Date { get; set; }

        [Required]
        [StringLength(100)]
        public string Review_Description { get; set; }

        public string Notes { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Actioned { get; set; }
    }
}
